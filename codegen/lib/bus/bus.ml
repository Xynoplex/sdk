(* The bus group: every SDK's bus vocabulary, from
   protocol/specs/src/bus/registry.json, and the names a credential goes by,
   which Kotlin's bus log withholds (protocol/specs/src/bus/log-cases.json). *)

module Registry = Registry
module Typescript = Typescript
module Go = Go
module Python = Python
module Kotlin = Kotlin
module Csharp = Csharp
module Rust = Rust

let errors = function Ok _ -> [] | Error errors -> errors

let files ~root:_ spec =
  let component = Registry.component spec in
  match Registry.derive ~component spec.Spec.tables.bus_registry with
  | Ok bus -> (
      let kotlin =
        Result.bind (Kotlin_sdk.types_of spec) (fun types ->
            Kotlin.files ~component ~types ~log_cases:spec.tables.bus_log_cases
              bus)
      in
      match
        (Go.files bus, Python.files bus, Rust.files bus component, kotlin)
      with
      | Ok go, Ok python, Ok rust, Ok kotlin ->
          Ok
            (Typescript.files bus @ go @ python @ rust @ kotlin
            @ [ Csharp.file bus ])
      | go, python, rust, kotlin ->
          Error (errors go @ errors python @ errors rust @ errors kotlin))
  | Error errors -> Error errors
