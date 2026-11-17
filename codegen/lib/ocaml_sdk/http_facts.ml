(* What the OCaml SDK's HTTP transport says (ocaml/sdk/lib/http_facts.ml):
   the method and path of each operation it calls, by operationId; the
   transport code each status becomes; the bus code each of CommandError's
   codes becomes; the statuses a transport retries; and ResourceUpload's
   members. Which operations it calls is the SDK's, each by its operationId;
   one the document no longer has is refused. *)

let string = Text.ocaml_quoted

let routes =
  [
    ("subscribe", "subscribeToBus");
    ("emit", "emitOnBus");
    ("health", "getHealth");
    ("status", "getStatus");
    ("current_user", "getCurrentUser");
    ("protected_resource_metadata", "getProtectedResourceMetadata");
    ("media_token", "createMediaToken");
    ("representation", "getResourceRepresentation");
    ("graph", "getResourceJsonLd");
    ("annotations", "getResourceAnnotations");
    ("anchored_text", "getResourceAnchoredText");
    ("upload", "uploadResource");
  ]

let file (spec : Spec.t) (codes : Error_codes.Table.t) =
  let refusals = ref [] in
  let refuse file pointer message =
    refusals := { Decode.file; pointer; message } :: !refusals
  in
  let operations =
    List.concat_map
      (fun (template, reference) ->
        let file, _ = Decode.resolve reference in
        match List.assoc_opt file spec.path_items with
        | None -> []
        | Some (item : Openapi.path_item) ->
            List.filter_map
              (fun (method_, operation) ->
                Option.map
                  (fun (o : Openapi.operation) -> (o.operation_id, (method_, template)))
                  operation)
              [ ("GET", item.get); ("PUT", item.put); ("POST", item.post) ])
      spec.gateway.paths
  in
  let route (name, id) =
    match List.assoc_opt id operations with
    | Some (method_, template) ->
        Printf.sprintf "let %s = (%s, %s)" name (string method_) (string template)
    | None ->
        refuse "openapi.json" "/paths"
          (Printf.sprintf "has no operation %s, which the OCaml SDK calls as %s"
             id name);
        ""
  in
  let routes = List.map route routes in
  let status_code =
    List.map
      (fun (status, (c : Error_codes.Table.code)) ->
        Printf.sprintf "  | %d -> %s" status (string c.code))
      codes.exact
    @ (match codes.from with
      | None -> []
      | Some (status, c) ->
          [ Printf.sprintf "  | status when status >= %d -> %s" status (string c.code) ])
    @ [ "  | _ -> " ^ string codes.unclassified.code ]
  in
  let failures =
    List.map
      (fun (wire, (c : Error_codes.Table.code)) ->
        let constructor =
          String.capitalize_ascii (String.map (function '-' -> '_' | x -> x) wire)
        in
        if
          (match constructor.[0] with 'A' .. 'Z' -> false | _ -> true)
          || not
            (String.for_all
               (function 'a' .. 'z' | '0' .. '9' | '_' -> true | _ -> false)
               (String.sub constructor 1 (String.length constructor - 1)))
        then
          refuse "components/schemas/CommandError.json" "/properties/code/enum"
            (Printf.sprintf "states %s, which names no OCaml constructor" wire);
        (wire, c.code, constructor))
      codes.wire
  in
  let retry_statuses =
    List.sort_uniq compare
      (List.filter_map
         (function
           | Tables.Retry_cases.Transport { retries = true; status = Some s; _ } ->
               Some s
           | _ -> None)
         spec.tables.retry_cases.rules)
  in
  let upload_fields =
    match List.assoc_opt "components/schemas/ResourceUpload.json" spec.schemas with
    | Some (Schema.Schema { properties = Some properties; _ }) -> List.map fst properties
    | _ ->
        refuse "components/schemas/ResourceUpload.json" "/properties" "states no members";
        []
  in
  let lines =
    [
      Banner.ocaml ~from_:"OpenAPI paths, error codes and retry cases" __FILE__;
    ]
    @ routes
    @ ("let status_code = function" :: status_code)
    @ [
        "module Failure_code = struct";
        "  type t = " ^ String.concat " | " (List.map (fun (_, _, c) -> c) failures);
        "  let of_wire = function";
      ]
    @ List.map (fun (w, _, c) -> "    | " ^ string w ^ " -> " ^ c) failures
    @ [
        "    | code -> invalid_arg (\"a failure's code \\\"\" ^ code ^ \"\\\" is none \
         of CommandError's: the reader leaves such a code out\")";
        "end";
        "let bus_failure = function";
        "  | None -> " ^ string codes.unrecognized.code;
      ]
    @ List.map
        (fun (_, code, c) -> "  | Some Failure_code." ^ c ^ " -> " ^ string code)
        failures
    @ [
        "let retry_statuses = ["
        ^ String.concat "; " (List.map string_of_int retry_statuses)
        ^ "]";
        "let upload_fields = ["
        ^ String.concat "; " (List.map string upload_fields)
        ^ "]";
        "";
      ]
  in
  match List.rev !refusals with
  | [] -> Ok { Output.path = "ocaml/sdk/lib/http_facts.ml"; text = String.concat "\n" lines }
  | errors -> Error errors
