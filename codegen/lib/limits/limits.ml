(* The limits group: the limits the gateway's API states (protocol/specs/src/
   openapi.json), for the TypeScript SDK: each operation's x-xynolog-limits,
   by "METHOD path", and each component's properties' maxItems, by
   "Schema.property". A gateway enforces them and a client plans around
   them, so an implementation reads them from here rather than restating a
   number. *)

let quoted = Text.quoted

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

(* An object as JSON.stringify writes it two spaces to a level, which is how
   the TypeScript module has always held these. *)
let rec json ~indent members =
  match members with
  | [] -> "{}"
  | members ->
      let inner = indent ^ "  " in
      "{\n"
      ^ String.concat ",\n"
          (List.map
             (fun (key, value) -> inner ^ quoted key ^ ": " ^ value inner)
             members)
      ^ "\n" ^ indent ^ "}"

and limit (l : Openapi.limit) indent =
  match l with
  | Count n -> string_of_int n
  | Unlimited -> quoted "unlimited"
  | Limits limits -> json ~indent (List.map (fun (k, v) -> (k, limit v)) limits)

let typescript t =
  {
    Output.path = "typescript/core/src/protocol-limits.ts";
    text =
      String.concat ""
        [
          "// ⚠ GENERATED FILE — do not edit.\n\
           //\n\
           // Authority:   protocol/specs/src/openapi.json and the files it \
           names\n\
           // Regenerate:  make generate  (";
          Banner.writer __FILE__;
          ")\n\n\
           /** Each operation's `x-xynolog-limits`, by `METHOD path`. */\n\
           export const operationLimits = ";
          json ~indent:""
            (List.map
               (fun (key, limits) ->
                 (key, fun indent -> limit (Openapi.Limits limits) indent))
               t.operations);
          " as const;\n\n\
           /** Each schema property's `maxItems`, by `Schema.property`. */\n\
           export const itemLimits = ";
          json ~indent:""
            (List.map (fun (key, n) -> (key, fun _ -> string_of_int n)) t.items);
          " as const;\n";
        ];
  }

let files ~root:_ (spec : Spec.t) =
  Result.map (fun t -> [ typescript t ]) (derive spec)
