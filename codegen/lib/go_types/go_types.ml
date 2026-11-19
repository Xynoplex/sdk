(* The Go SDK's protocol types (go/api/types_gen.go): a type for every
   component schema of the gateway's document and every record Protocol
   states in its tables ([Table_records]), with every schema they reach, but
   the kinds of id, which go/api/ids_gen.go declares. *)

module Generate = Generate

let path = "go/api/types_gen.go"

let generated (spec : Spec.t) =
  let bundle = Definitions.bundle spec in
  let identifiers =
    List.map
      (fun (k : Tables.Identifiers_kinds.kinds_item) -> k.schema)
      spec.tables.identifiers_kinds.kinds
  in
  let roots =
    List.filter (fun n -> not (List.mem n identifiers)) bundle.definitions.names
    @ List.map (fun (_, name, _) -> name) (Definitions.records spec)
  in
  ( Generate.generate bundle.definitions ~identifiers roots,
    List.map (fun name -> (name, None)) identifiers )

(* Every type package api declares, and what it is an alias of, if it is
   one: the generated types and the kinds of id. *)
let declared spec =
  let generated, identifiers = generated spec in
  generated.declared @ identifiers

let file spec =
  let generated, _ = generated spec in
  {
    Output.path;
    text =
      Go_syntax.text
        {
          header =
            Go_syntax.verbatim
              ("Code generated from the component schemas of \
                protocol/specs/src/openapi.json — DO NOT EDIT.\n\n\
                Regenerate: make generate (" ^ Banner.writer __FILE__ ^ ")");
          package = "api";
          imports = (match generated.imports with [] -> [] | used -> [ used ]);
          decls = generated.decls;
        };
  }

let files ~root:_ (spec : Spec.t) =
  match file spec with
  | file -> Ok [ file ]
  | exception Definitions.Refused message ->
      Error [ { Decode.file = "openapi.json"; pointer = ""; message } ]
