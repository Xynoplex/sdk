(* The Haskell SDK's HTTP routes: one constructor of HttpRoute for each of the
   gateway's operations, typed by what it is asked and answers, with its
   method, path, status, media types, whether it needs a credential and the
   headers it requires; the schemas of what an operation states in place,
   which the models name after it; the bus's event name; and what the
   reference transport reads as a refused credential, read from
   typescript/http-transport's refusesCredential and held to LimitRefusal's
   codes. *)

module H = Haskell_syntax

let ( let* ) = Result.bind

type route = {
  constructor : string;
  method_ : string;
  path : string;
  input : string;
  output : string;
  input_media : string option;
  output_media : string;
  status : string;
  authenticated : bool;
  headers : (string * string) list;  (** Each header, and its schema's name. *)
}

type t = {
  routes : route list;
  schemas : (string * Schema.t) list;
      (** What the routes state in place, by the names the models give them. *)
}

let refused message = Error message

(* [f] of each of [xs], in order, or the first refusal. *)
let each f xs =
  Result.map List.rev
    (List.fold_left
       (fun found x ->
         let* found = found in
         let* y = f x in
         Ok (y :: found))
       (Ok []) xs)

let one what = function [ x ] -> Ok x | _ -> Error ("HTTP " ^ what)

let base_name (r : Decode.reference) =
  Filename.remove_extension (Filename.basename r.target)

let routes (spec : Spec.t) =
  let* rows =
    each
      (fun (path, (reference : Decode.reference)) ->
        let file, _ = Decode.resolve reference in
        let* item =
          match List.assoc_opt file spec.path_items with
          | Some item -> Ok item
          | None -> refused ("no path item " ^ file)
        in
        let operations =
          List.filter_map
            (fun (m, o) -> Option.map (fun o -> (m, o)) o)
            [
              ("get", item.Openapi.get); ("post", item.post); ("put", item.put);
            ]
        in
        each
          (fun (method_, (operation : Openapi.operation)) ->
            let name = operation.operation_id in
            let constructor = String.capitalize_ascii name in
            let* status, response =
              one "operation needs one success status"
                (List.filter
                   (fun (status, _) -> String.starts_with ~prefix:"2" status)
                   operation.responses)
            in
            let* response =
              match response with
              | Openapi.Inline r -> Ok r
              | Ref _ -> refused "success has no content"
            in
            let* media, answer =
              match response.content with
              | Some content -> one "success needs one content type" content
              | None -> refused "HTTP success has no content"
            in
            let* output, extra =
              match answer.schema with
              | Schema { ref_ = Some r; _ } -> Ok (base_name r, [])
              | Schema { format = Some Binary; _ } -> Ok ("ByteString", [])
              | schema ->
                  Ok
                    ( constructor ^ "Response",
                      [ (constructor ^ "Response", schema) ] )
            in
            let authenticated =
              operation.security <> [] && not (List.mem [] operation.security)
            in
            let* input, input_media, request_extra =
              match operation.request_body with
              | None -> Ok ("()", None, [])
              | Some body -> (
                  let* () =
                    if body.required then Ok ()
                    else
                      refused
                        "optional HTTP bodies need an explicit encoding rule"
                  in
                  let* media, described =
                    one "body needs one content type" body.content
                  in
                  match described.schema with
                  | Schema ({ ref_ = Some r; _ } as s) ->
                      if
                        List.for_all
                          (fun k ->
                            List.mem k [ "$ref"; "description"; "$comment" ])
                          (Schema.keywords s)
                      then Ok (base_name r, Some media, [])
                      else
                        refused "constrained HTTP body reference needs a model"
                  | schema ->
                      Ok
                        ( constructor ^ "Request",
                          Some media,
                          [ (constructor ^ "Request", schema) ] ))
            in
            let headers =
              List.concat
                (List.mapi
                   (fun i (p : Openapi.parameter) ->
                     if p.in_ = Header && p.required then
                       [
                         ( p.name,
                           constructor ^ "Header" ^ string_of_int i,
                           p.schema );
                       ]
                     else [])
                   (Option.value operation.parameters ~default:[]))
            in
            Ok
              ( {
                  constructor;
                  method_ = String.uppercase_ascii method_;
                  path;
                  input;
                  output;
                  input_media;
                  output_media = media;
                  status;
                  authenticated;
                  headers = List.map (fun (h, n, _) -> (h, n)) headers;
                },
                extra @ request_extra
                @ List.map (fun (_, n, s) -> (n, s)) headers ))
          operations)
      (List.sort (fun (a, _) (b, _) -> String.compare a b) spec.gateway.paths)
  in
  let rows = List.concat rows in
  let names = List.map (fun (r, _) -> r.constructor) rows in
  if List.length (List.sort_uniq String.compare names) <> List.length names then
    refused "HTTP constructor collision"
  else Ok { routes = List.map fst rows; schemas = List.concat_map snd rows }

(* What the reference transport reads as a refused credential: a status, or
   another status with a body whose member is a code, which must be one of
   LimitRefusal's. *)
type credential = {
  unauthorized : int;
  limited : int;
  field : string;
  refusal : string;
}

let classifier = "typescript/http-transport/src/transport/api-error.ts"

let credential ~root =
  let source =
    In_channel.with_open_bin
      (Filename.concat root classifier)
      In_channel.input_all
  in
  let signature =
    "export function refusesCredential(status: number, body: unknown): boolean \
     {"
  in
  let after text marker =
    match Marker.find marker text with
    | Some i -> String.sub text i (String.length text - i)
    | None -> ""
  in
  let section = after source signature in
  let body =
    let from = String.index_opt section '{' in
    match from with
    | None -> ""
    | Some i -> (
        let rest = String.sub section i (String.length section - i) in
        match Marker.find "\n}" rest with
        | Some j -> String.sub rest 0 j
        | None -> rest)
  in
  let words_of text =
    List.filter (( <> ) "")
      (String.split_on_char ' '
         (String.map (function '\n' | '\t' | '\r' -> ' ' | c -> c) text))
  in
  let words = words_of body in
  let strip ~prefix ~suffix text =
    if String.starts_with ~prefix text && String.ends_with ~suffix text then
      Some
        (String.sub text (String.length prefix)
           (String.length text - String.length prefix - String.length suffix))
    else None
  in
  let* unauthorized, limited, field, constant =
    match words with
    | [
     "{";
     "return";
     "(";
     "status";
     "===";
     one;
     "||";
     "(status";
     "===";
     two;
     "&&";
     "isObject(body)";
     "&&";
     member;
     "===";
     symbol;
     ");";
    ] -> (
        match
          ( int_of_string_opt one,
            int_of_string_opt two,
            strip ~prefix:"body['" ~suffix:"']" member,
            strip ~prefix:"" ~suffix:")" symbol )
        with
        | Some a, Some b, Some f, Some c -> Ok (a, b, f, c)
        | _ -> refused "unreadable credential refusal")
    | _ ->
        refused
          "credential refusal reference changed; update the Haskell derivation"
  in
  (* The constant's value, its declaration read as words: a line may break
     after its [=]. *)
  let* refusal =
    let opening = "const " ^ constant ^ " = '" in
    match after (String.concat " " (words_of source)) opening with
    | "" -> refused "unreadable credential refusal constant"
    | rest -> (
        let value =
          String.sub rest (String.length opening)
            (String.length rest - String.length opening)
        in
        match String.index_opt value '\'' with
        | Some i when i > 0 -> Ok (String.sub value 0 i)
        | _ -> refused "unreadable credential refusal constant")
  in
  Ok { unauthorized; limited; field; refusal }

let route_type = H.T_apply ("HttpRoute", [ T_name "request"; T_name "answer" ])

let dispatch name result routes value =
  H.Value
    {
      about = [];
      name;
      type_ = T_fun (route_type, result);
      clauses =
        List.map
          (fun r ->
            { H.patterns = [ Constructor (r.constructor, []) ]; body = value r })
          routes;
    }

(* A route's type: a model, ByteString, or () for a route that takes no body. *)
let text = function "()" -> H.T_tuple [] | value -> H.T_name value

let file ~banner t ~credential ~bus_event =
  let routes = t.routes in
  let body =
    [
      H.Gadt
        {
          about = [];
          name = "HttpRoute";
          params = [ ("request", None); ("answer", None) ];
          constructors =
            List.map
              (fun r ->
                ( r.constructor,
                  H.T_apply ("HttpRoute", [ text r.input; text r.output ]) ))
              routes;
        };
      dispatch "routeName" (text "Text") routes (fun r -> Str r.constructor);
      dispatch "routeMethod" (text "ByteString") routes (fun r -> Str r.method_);
      dispatch "routePath" (text "Text") routes (fun r -> Str r.path);
      dispatch "routeStatus" (text "Int") routes (fun r ->
          Int (int_of_string r.status));
      dispatch "routeMediaType" (text "ByteString") routes (fun r ->
          Str r.output_media);
      dispatch "routeRequestMediaType"
        (H.T_apply ("Maybe", [ text "ByteString" ]))
        routes
        (fun r ->
          match r.input_media with
          | None -> Name "Nothing"
          | Some m -> Apply (Name "Just", [ Str m ]));
      dispatch "routeAuthenticated" (text "Bool") routes (fun r ->
          Name (if r.authenticated then "True" else "False"));
      dispatch "routeRequiredHeaders"
        (H.T_list (T_tuple [ text "ByteString"; text "Text" ]))
        routes
        (fun r ->
          List (List.map (fun (h, n) -> H.Tuple [ Str h; Str n ]) r.headers));
      H.value "unauthorizedStatus" (text "Int") (Int credential.unauthorized);
      H.value "limitedStatus" (text "Int") (Int credential.limited);
      H.value "refusalField" (text "Key") (Str credential.field);
      H.value "refusalCode" (text "Text") (Str credential.refusal);
      H.value "busEventName" (text "Text") (Str bus_event);
    ]
  in
  let used = H.uses body in
  let types =
    List.sort_uniq String.compare
      (List.concat_map (fun r -> [ r.input; r.output ]) routes)
  in
  let models =
    List.exists
      (fun t -> List.mem t used.types && t <> "ByteString" && t <> "()")
      types
  in
  {
    H.banner;
    extensions = [ "GADTs"; "OverloadedStrings" ];
    name = "Xynolog.Http.Routes";
    imports =
      ([
         H.import "Data.Aeson.Key" ~items:[ Plain "Key" ];
         H.import "Data.ByteString" ~items:[ Plain "ByteString" ];
         H.import "Data.Text" ~items:[ Plain "Text" ];
       ]
      @ if models then [ H.import "Xynolog.Types" ] else []);
    body;
  }
