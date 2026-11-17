(* The encodings group: the Encoding Standard's labels, its single-byte
   encodings and the encodings whose labels are refused
   (protocol/specs/src/text/encoding-cases.json), for the readers of a
   resource's text whose platform lacks them. Table derives it; Go, Python
   and Typescript write it. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t ->
      [
        Go.file t;
        Python.file t;
        Typescript.file t;
        Ocaml.file spec.tables.text_encoding_cases;
      ])
    (Table.derive spec.tables.text_encoding_cases)
