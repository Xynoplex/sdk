(* The error-codes group: the codes a client reports a failure under
   (protocol/specs/src/errors/codes.json), the bus code each of the wire's own
   codes becomes and the transport code each HTTP status becomes, for the Go,
   Python, TypeScript, OCaml and Kotlin SDKs. Table derives them and holds the
   table to the wire's codes (CommandError.code); Go, Python, Typescript,
   Ocaml and Kotlin write them. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml
module Kotlin = Kotlin

let files ~root:_ (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* wire_codes = Table.wire_codes spec in
  let* t = Table.derive ~wire_codes spec.tables.errors_codes in
  let* ocaml = Ocaml.file t in
  let* types = Kotlin_sdk.types_of spec in
  let* kotlin =
    Kotlin_sdk.written ~from_:Table.file (fun () ->
        Kotlin.file ~types ~wire_codes t)
  in
  Ok [ Go.file t; Python.file t; Typescript.file t; ocaml; kotlin ]
