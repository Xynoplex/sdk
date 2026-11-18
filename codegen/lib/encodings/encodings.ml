(* The encodings group: the Encoding Standard's labels, its single-byte
   encodings and the encodings whose labels are refused
   (protocol/specs/src/text/encoding-cases.json), for the readers of a
   resource's text whose platform lacks them. Table derives it; Go, Python,
   Typescript, Ocaml and Kotlin write it. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml
module Kotlin = Kotlin
module Rust = Rust

let files ~root:_ (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* t = Table.derive spec.tables.text_encoding_cases in
  let* rust = Rust.files spec.tables.text_encoding_cases in
  Ok
    ([
       Go.file t;
       Python.file t;
       Typescript.file t;
       Ocaml.file spec.tables.text_encoding_cases;
       Kotlin.file t;
     ]
    @ rust)
