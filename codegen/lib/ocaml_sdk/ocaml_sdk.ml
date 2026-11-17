(* The OCaml SDK's modules that no other group's table owns: the string
   enums, the selector and the records of the component schemas. Each
   group that owns a table writes the OCaml SDK's module of it itself. *)

module Enums = Enums
module Selector = Selector
module Records = Records

let files ~root:_ (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* enums = Enums.derive spec in
  let* selector = Selector.derive spec in
  let* records = Records.derive spec in
  Ok (Enums.files enums @ Selector.files selector @ Records.files records)
