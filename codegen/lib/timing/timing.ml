(* The timing group: a client's deadlines, retry budgets, the cadence of its
   stream and what it keeps count of (protocol/specs/src/client/timing.json),
   for the Go, Python and TypeScript SDKs. Table holds every entry to the kind
   its name says; Go, Python and Typescript write them. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml

let files ~root:_ (spec : Spec.t) =
  Result.map
    (fun t -> [ Go.file t; Python.file t; Typescript.file t ] @ Ocaml.files t)
    (Table.derive spec.tables.client_timing)
