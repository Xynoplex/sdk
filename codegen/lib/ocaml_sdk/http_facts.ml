(* What the OCaml SDK's HTTP transport says (ocaml/sdk/lib/http_facts.ml):
   the method and path of each operation it calls, by operationId; the
   transport code each status becomes; the bus code each of CommandError's
   codes becomes; and ResourceUpload's members. Which operations it calls is
   the SDK's, each by its operationId; one the document no longer has is
   refused. *)

module O = Ocaml_syntax

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
        let file, _ = Decode.resolve spec.Spec.ids reference in
        match List.assoc_opt file spec.path_items with
        | None -> []
        | Some (item : Openapi.path_item) ->
            List.filter_map
              (fun (method_, operation) ->
                Option.map
                  (fun (o : Openapi.operation) ->
                    (o.operation_id, (method_, template)))
                  operation)
              [ ("GET", item.get); ("PUT", item.put); ("POST", item.post) ])
      spec.gateway.paths
  in
  let route (name, id) =
    match List.assoc_opt id operations with
    | Some (method_, template) ->
        [ O.let_ name (O.tuple [ O.string method_; O.string template ]) ]
    | None ->
        refuse "openapi.json" "/paths"
          (Printf.sprintf "has no operation %s, which the OCaml SDK calls as %s"
             id name);
        []
  in
  let routes = List.concat_map route routes in
  let status_code =
    List.map
      (fun (status, (c : Error_codes.Table.code)) ->
        O.case (O.Pattern.int status) (O.string c.code))
      codes.exact
    @ (match codes.from with
      | None -> []
      | Some (status, c) ->
          [
            O.case (O.Pattern.var "status")
              ~guard:(O.infix ">=" (O.ident "status") (O.int status))
              (O.string c.code);
          ])
    @ [ O.case O.Pattern.any (O.string codes.unclassified.code) ]
  in
  let failures =
    List.map
      (fun (wire, (c : Error_codes.Table.code)) ->
        let constructor =
          String.capitalize_ascii
            (String.map (function '-' -> '_' | x -> x) wire)
        in
        if
          (match constructor.[0] with 'A' .. 'Z' -> false | _ -> true)
          || not
               (String.for_all
                  (function
                    | 'a' .. 'z' | '0' .. '9' | '_' -> true | _ -> false)
                  (String.sub constructor 1 (String.length constructor - 1)))
        then
          refuse "components/schemas/CommandError.json" "/properties/code/enum"
            (Printf.sprintf "states %s, which names no OCaml constructor" wire);
        (wire, c.code, constructor))
      codes.wire
  in
  let upload_fields =
    match
      List.assoc_opt "components/schemas/ResourceUpload.json" spec.schemas
    with
    | Some (Schema.Schema { properties = Some properties; _ }) ->
        List.map fst properties
    | _ ->
        refuse "components/schemas/ResourceUpload.json" "/properties"
          "states no members";
        []
  in
  let failure_code =
    O.module_ "Failure_code"
      [
        O.type_item
          (O.type_declaration "t"
             (Variant (List.map (fun (_, _, c) -> O.constructor c) failures)));
        O.let_ "of_wire"
          (O.function_
             (List.map
                (fun (w, _, c) -> O.case (O.Pattern.string w) (O.construct c))
                failures
             @ [
                 O.case (O.Pattern.var "code")
                   (O.apply (O.ident "invalid_arg")
                      [
                        O.infix "^"
                          (O.string "a failure's code \"")
                          (O.infix "^" (O.ident "code")
                             (O.string
                                "\" is none of CommandError's: the reader \
                                 leaves such a code out"));
                      ]);
               ]));
      ]
  in
  let bus_failure =
    O.let_ "bus_failure"
      (O.function_
         (O.case (O.Pattern.construct "None") (O.string codes.unrecognized.code)
         :: List.map
              (fun (_, code, c) ->
                O.case
                  (O.Pattern.construct "Some"
                     ~arg:(O.Pattern.construct ("Failure_code." ^ c)))
                  (O.string code))
              failures))
  in
  let items =
    routes
    @ [
        O.let_ "status_code" (O.function_ status_code);
        failure_code;
        bus_failure;
        O.let_ "upload_fields" (O.list (List.map O.string upload_fields));
      ]
  in
  match List.rev !refusals with
  | [] ->
      Ok
        (O.implementation ~path:"ocaml/sdk/lib/http_facts.ml"
           ~banner:
             (Banner.ocaml ~from_:"OpenAPI paths and schemas, and error codes"
                __FILE__)
           items)
  | errors -> Error errors
