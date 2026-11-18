(* The Haskell SDK's transport facts: the connection states and the moves
   between them, as protocol/contract/TRANSPORT-HTTP.md draws them; the
   member a frame's trace context is lifted from; the members a trace carrier
   holds, as typescript/core's TraceCarrier states them, which the models
   type; and the member a user's identifier is stamped under. *)

module H = Haskell_syntax

let ( let* ) = Result.bind

type t = {
  carrier : (string * bool) list;
      (** Each member, and whether it's optional. *)
  states : (string * string list) list;  (** Each state, and where it moves. *)
  trace_field : string;
  user_field : string;
}

let event_bus = "typescript/core/src/event-bus.ts"
let contract = "protocol/contract/TRANSPORT-HTTP.md"
let trim = String.trim

let each f xs =
  Result.map List.rev
    (List.fold_left
       (fun found x ->
         let* found = found in
         let* y = f x in
         Ok (y :: found))
       (Ok []) xs)

let derive ~root (spec : Spec.t) =
  let* carrier =
    Marker.between "export interface TraceCarrier {\n" "\n}"
      (Marker.read ~root event_bus)
  in
  let* carrier =
    each
      (fun line ->
        match String.split_on_char ':' line with
        | key :: rest when String.starts_with ~prefix:"readonly " key ->
            let key = Marker.drop (String.length "readonly ") key in
            let optional = String.ends_with ~suffix:"?" key in
            let named =
              if optional then String.sub key 0 (String.length key - 1) else key
            in
            if trim (":" ^ String.concat ":" rest) = ": string;" then
              Ok (named, optional)
            else Error "unsupported TraceCarrier property type"
        | _ -> Error "unsupported TraceCarrier member")
      (List.filter
         (fun line ->
           line <> ""
           && not
                (List.exists
                   (fun p -> String.starts_with ~prefix:p line)
                   [ "/*"; "*"; "//" ]))
         (List.map trim (String.split_on_char '\n' carrier)))
  in
  let* () =
    if carrier = [] then Error "empty TraceCarrier interface" else Ok ()
  in
  let* section =
    Marker.between "### Connection lifecycle\n" "### Reconnect discipline"
      (Marker.read ~root contract)
  in
  let* graph = Marker.between "```\n" "\n```" section in
  let* states =
    each
      (fun line ->
        match Marker.find "→" line with
        | None -> Error "invalid connection-state graph row"
        | Some i ->
            let targets = trim (Marker.drop (i + String.length "→") line) in
            Ok
              ( trim (String.sub line 0 i),
                if targets = "(terminal)" then []
                else List.map trim (String.split_on_char '|' targets) ))
      (List.filter (( <> ) "")
         (List.map trim (String.split_on_char '\n' graph)))
  in
  let names = List.map fst states in
  let* () =
    if
      names = []
      || List.length (List.sort_uniq String.compare names) <> List.length names
    then Error "duplicate or missing connection states"
    else if
      not
        (List.for_all (fun t -> List.mem t names) (List.concat_map snd states))
    then Error "connection graph names an unknown state"
    else Ok ()
  in
  let* user_field =
    match
      List.concat_map
        (fun (k : Tables.Identifiers_kinds.kind) ->
          if k.schema = "UserId" then
            List.filter (String.starts_with ~prefix:"_") k.properties
          else [])
        spec.tables.identifiers_kinds.kinds
    with
    | [ field ] -> Ok field
    | _ -> Error "UserId needs exactly one authenticated stamp property"
  in
  Ok
    {
      carrier;
      states;
      trace_field = spec.tables.bus_registry.trace.field;
      user_field;
    }

(* The trace carrier as a schema: an object of strings, each required unless
   TraceCarrier makes it optional, and no other member. *)
let carrier_schema t =
  Schema.Schema
    {
      Schema.empty with
      type_ = Some [ Object ];
      additional_properties = Some (Boolean_schema false);
      properties =
        Some
          (List.map
             (fun (key, _) ->
               (key, Schema.Schema { Schema.empty with type_ = Some [ String ] }))
             t.carrier);
      required =
        Some
          (List.filter_map (fun (k, o) -> if o then None else Some k) t.carrier);
    }

let constructor = String.capitalize_ascii

let file ~banner t =
  let state = H.T_name "ConnectionState" in
  let text = H.T_name "Text" in
  {
    H.banner;
    extensions = [ "OverloadedStrings" ];
    name = "Xynolog.Transport.Facts";
    imports = [ H.import "Data.Text" ~items:[ Plain "Text" ] ];
    body =
      [
        H.data "ConnectionState"
          ~deriving:[ "Eq"; "Ord"; "Show"; "Enum"; "Bounded" ]
          (List.map (fun (s, _) -> H.constructor (constructor s)) t.states);
        Value
          {
            about = [];
            name = "connectionStateName";
            type_ = T_fun (state, text);
            clauses =
              List.map
                (fun (s, _) ->
                  {
                    H.patterns = [ Constructor (constructor s, []) ];
                    body = Str s;
                  })
                t.states;
          };
        Value
          {
            about = [];
            name = "connectionTransitions";
            type_ = T_fun (state, T_list state);
            clauses =
              List.map
                (fun (s, targets) ->
                  {
                    H.patterns = [ Constructor (constructor s, []) ];
                    body =
                      List (List.map (fun t -> H.Name (constructor t)) targets);
                  })
                t.states;
          };
        H.value "traceField" text (Str t.trace_field);
        H.value "traceCarrierFields" (T_list text)
          (List (List.map (fun (k, _) -> H.Str k) t.carrier));
        H.value "userField" text (Str t.user_field);
      ];
  }
