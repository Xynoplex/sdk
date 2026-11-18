(* The identifiers group: the kinds of id (protocol/specs/src/identifiers/
   kinds.json), each with its schema's rule, for the Go, Python and TypeScript
   SDKs. Table reads each kind's schema; Go also holds oapi-codegen's
   exclude-schemas to the table. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml
module Csharp = Csharp

let files ~root (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* kinds = Table.derive spec in
  let* go = Go.file ~root kinds in
  let* derivation = Required.derive spec in
  let* ocaml = Ocaml.files spec derivation.shapes in
  let csharp = Csharp.files kinds in
  match Output.stale ~root ~directory:Csharp.directory csharp with
  | [] -> Ok ([ go; Python.file kinds; Typescript.file kinds ] @ ocaml @ csharp)
  | stale -> Error stale
