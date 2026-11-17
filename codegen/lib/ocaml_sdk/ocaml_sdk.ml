(* The OCaml SDK's modules that no other group's table owns: the string
   enums, the selector and the records of the component schemas, what its
   HTTP transport says, and the facts of tables no group writes for it; and
   the repository's LICENSE, which its package ships. Each group that owns a
   table writes the OCaml SDK's module of it itself. *)

module Enums = Enums
module Selector = Selector
module Records = Records
module Http_facts = Http_facts
module Facts = Facts

let files ~root (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* enums = Enums.derive spec in
  let* selector = Selector.derive spec in
  let* records = Records.derive spec in
  let* wire_codes = Error_codes.Table.wire_codes spec in
  let* codes = Error_codes.Table.derive ~wire_codes spec.tables.errors_codes in
  let* http = Http_facts.file spec codes in
  let* facts = Facts.files spec in
  let license =
    In_channel.with_open_bin (Filename.concat root "LICENSE") In_channel.input_all
  in
  Ok
    (Enums.files enums @ Selector.files selector @ Records.files records
    @ (http :: facts)
    @ [ { Output.path = "ocaml/sdk/LICENSE"; text = license } ])
