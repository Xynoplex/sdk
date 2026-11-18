(* The bus group: every SDK's bus vocabulary, from protocol/specs/src/bus/registry.json. *)

module Registry = Registry
module Typescript = Typescript
module Go = Go
module Python = Python
module Rust = Rust

let errors = function Ok _ -> [] | Error errors -> errors

let files ~root:_ spec =
  let component = Registry.component spec in
  match Registry.derive ~component spec.Spec.tables.bus_registry with
  | Ok bus -> (
      match (Go.files bus, Python.files bus, Rust.files bus component) with
      | Ok go, Ok python, Ok rust ->
          Ok (Typescript.files bus @ go @ python @ rust)
      | go, python, rust -> Error (errors go @ errors python @ errors rust))
  | Error errors -> Error errors
