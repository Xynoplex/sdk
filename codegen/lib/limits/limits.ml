(* The limits group: the limits the gateway's API states (protocol/specs/src/
   openapi.json), for the TypeScript SDK: each operation's x-xynolog-limits,
   by "METHOD path", and each component's properties' maxItems, by
   "Schema.property". A gateway enforces them and a client plans around
   them, so an implementation reads them from here rather than restating a
   number. *)

type t = {
  operations : (string * Openapi.limits) list;
  items : (string * int) list;
}

let derive (spec : Spec.t) =
  let refusals = ref [] in
  let operations =
    List.concat_map
      (fun (template, reference) ->
        let file, _ = Decode.resolve reference in
        match List.assoc_opt file spec.path_items with
        | None ->
            refusals :=
              {
                Decode.file = "openapi.json";
                pointer = "/paths/" ^ Decode.escape template;
                message = "names a path item the model has not read";
              }
              :: !refusals;
            []
        | Some (item : Openapi.path_item) ->
            List.filter_map
              (fun (method_, operation) ->
                Option.bind operation (fun (o : Openapi.operation) ->
                    Option.map
                      (fun limits -> (method_ ^ " " ^ template, limits))
                      o.limits))
              [ ("GET", item.get); ("PUT", item.put); ("POST", item.post) ])
      spec.gateway.paths
  in
  let items =
    List.concat_map
      (fun (name, reference) ->
        let file, _ = Decode.resolve reference in
        match List.assoc_opt file spec.schemas with
        | Some (Schema.Schema { properties = Some properties; _ }) ->
            List.filter_map
              (fun (property, declared) ->
                match declared with
                | Schema.Schema { max_items = Some n; _ } ->
                    Some (name ^ "." ^ property, n)
                | _ -> None)
              properties
        | Some _ -> []
        | None ->
            refusals :=
              {
                Decode.file = "openapi.json";
                pointer = "/components/schemas/" ^ Decode.escape name;
                message = "names a schema the model has not read";
              }
              :: !refusals;
            [])
      spec.gateway.components.schemas
  in
  match List.rev !refusals with
  | [] -> Ok { operations; items }
  | errors -> Error errors

let rec limit : Openapi.limit -> Yojson.Safe.t = function
  | Count n -> `Int n
  | Unlimited -> `String "unlimited"
  | Limits limits -> `Assoc (List.map (fun (k, v) -> (k, limit v)) limits)

let typescript t =
  let module S = Typescript_syntax in
  {
    Output.path = "typescript/core/src/protocol-limits.ts";
    text =
      S.text
        {
          banner =
            Banner.typescript_lines
              ~authority:
                [ "protocol/specs/src/openapi.json and the files it names" ]
              __FILE__;
          body =
            [
              S.const "operationLimits" ~as_const:true
                ~about:
                  [
                    Doc "Each operation's `x-xynolog-limits`, by `METHOD path`.";
                  ]
                (Json_rows
                   (`Assoc
                      (List.map
                         (fun (key, limits) ->
                           (key, limit (Openapi.Limits limits)))
                         t.operations)));
              S.const "itemLimits" ~as_const:true
                ~about:
                  [
                    Doc
                      "Each schema property's `maxItems`, by `Schema.property`.";
                  ]
                (Json_rows
                   (`Assoc (List.map (fun (key, n) -> (key, `Int n)) t.items)));
            ];
        };
  }

let files ~root:_ (spec : Spec.t) =
  Result.map (fun t -> [ typescript t ]) (derive spec)
