(* The error-codes group: the codes a client reports a failure under
   (protocol/specs/src/errors/codes.json), the bus code each of the wire's own
   codes becomes and the transport code each HTTP status becomes, for the Go,
   Python and TypeScript SDKs. Table derives them and holds the table to the
   wire's codes (CommandError.code); Go, Python and Typescript write them. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Ocaml = Ocaml
module Rust = Rust

let files ~root:_ (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* wire_codes = Table.wire_codes spec in
  let* t = Table.derive ~wire_codes spec.tables.errors_codes in
  let* ocaml = Ocaml.file t in
  Ok
    [
      Go.file t;
      Python.file t;
      Typescript.file t;
      ocaml;
      Rust.file ~wire_codes t;
    ]
