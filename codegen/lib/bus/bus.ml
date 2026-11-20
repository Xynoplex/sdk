(* The bus group: every SDK's bus vocabulary, from
   protocol/specs/src/bus/registry.json, and the names a credential goes by,
   which the bus logs withhold (protocol/specs/src/bus/log-cases.json). *)

module Registry = Registry
module Typescript = Typescript
module Go = Go
module Python = Python
module Kotlin = Kotlin
module Csharp = Csharp
module Rust = Rust
module Credentials = Credentials

let errors = function Ok _ -> [] | Error errors -> errors

let files ~root:_ spec =
  let component = Registry.component spec in
  match
    Result.bind (User_stamp.field spec.Spec.tables.identifiers_kinds)
      (fun user_field ->
        Registry.derive ~ids:spec.Spec.ids ~component ~user_field
          spec.Spec.tables.bus_registry)
  with
  | Ok bus -> (
      let kotlin =
        Result.bind (Kotlin_sdk.types_of spec) (fun types ->
            Kotlin.files ~component ~types bus)
      in
      match
        ( Go.files bus,
          Python.files bus,
          Rust.files bus component,
          kotlin,
          Credentials.files spec.tables.bus_log_cases )
      with
      | Ok go, Ok python, Ok rust, Ok kotlin, Ok credentials ->
          Ok
            (Typescript.files bus @ go @ python @ rust @ kotlin
            @ [ Csharp.file bus ]
            @ credentials)
      | go, python, rust, kotlin, credentials ->
          Error
            (errors go @ errors python @ errors rust @ errors kotlin
           @ errors credentials))
  | Error errors -> Error errors
