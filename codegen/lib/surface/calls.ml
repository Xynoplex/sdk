(* Each SDK's surface test's calls, from protocol/specs/src/client/surface.json
   ([Methods]): every method called with a case's arguments, as the SDK takes
   its parameters. *)

let files ~root:_ (spec : Spec.t) =
  match
    let methods = Methods.derive spec in
    let definitions = (Definitions.bundle spec).definitions in
    let kinds =
      List.map
        (fun (k : Tables.Identifiers_kinds.kinds_item) -> k.schema)
        spec.tables.identifiers_kinds.kinds
    in
    [ Python.file ~kinds definitions methods ]
  with
  | files -> Ok files
  | exception Definitions.Refused message ->
      Error [ { Decode.file = Methods.file; pointer = ""; message } ]
