(* The bus group: every SDK's bus vocabulary, from protocol/specs/src/bus/registry.json. *)

module Registry = Registry
module Typescript = Typescript
module Go = Go
module Python = Python
module Csharp = Csharp

let errors = function Ok _ -> [] | Error errors -> errors

let files ~root:_ spec =
  match
    Registry.derive ~component:(Registry.component spec)
      spec.Spec.tables.bus_registry
  with
  | Ok bus -> (
      match (Go.files bus, Python.files bus) with
      | Ok go, Ok python ->
          Ok (Typescript.files bus @ go @ python @ [ Csharp.file bus ])
      | go, python -> Error (errors go @ errors python))
  | Error errors -> Error errors
