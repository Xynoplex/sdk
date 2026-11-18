(* The timing group: a client's deadlines, retry budgets, the cadence of its
   stream and what it keeps count of (protocol/specs/src/client/timing.json),
   for the Go, Python, TypeScript, OCaml, Haskell and Kotlin SDKs. Table holds
   every entry to the kind its name says; Go, Python, Typescript and Kotlin
   write them. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml
module Haskell = Haskell
module Kotlin = Kotlin

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t ->
      [ Go.file t; Python.file t; Typescript.file t; Kotlin.file t ]
      @ Ocaml.files t @ Haskell.files t)
    (Table.derive spec.tables.client_timing)
