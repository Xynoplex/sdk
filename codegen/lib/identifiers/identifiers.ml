(* The identifiers group: the kinds of id (protocol/specs/src/identifiers/
   kinds.json), each with its schema's rule, for the Go, Python and TypeScript
   SDKs. Table reads each kind's schema; Go also holds oapi-codegen's
   exclude-schemas to the table. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript

let files ~root (spec : Spec.t) =
  Result.bind (Table.derive spec) (fun kinds ->
      Result.map
        (fun go -> [ go; Python.file kinds; Typescript.file kinds ])
        (Go.file ~root kinds))
