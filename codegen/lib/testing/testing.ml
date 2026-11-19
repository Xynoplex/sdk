(* The testing group: the testing kit's facts (protocol/specs/src/client/
   testing.json) for the Haskell, OCaml, TypeScript and Rust SDKs. Table
   holds the table to what they read of it; each writes its language's file. *)

module Table = Table
module Haskell = Haskell
module Ocaml = Ocaml
module Typescript = Typescript
module Rust = Rust

let files ~root:_ (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* table = Table.derive spec.tables.client_testing in
  let* haskell = Haskell.file table in
  let* typescript = Typescript.file table in
  let* rust = Rust.file table in
  Ok [ haskell; Ocaml.file table; typescript; rust ]
