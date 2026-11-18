(* The bus group: every SDK's bus vocabulary, from
   protocol/specs/src/bus/registry.json, and the names a credential goes by,
   which Kotlin's bus log withholds (protocol/specs/src/bus/log-cases.json). *)

module Registry = Registry
module Typescript = Typescript
module Go = Go
module Python = Python
module Kotlin = Kotlin

let errors = function Ok _ -> [] | Error errors -> errors

let files ~root:_ spec =
  let component = Registry.component spec in
  match Registry.derive ~component spec.Spec.tables.bus_registry with
  | Ok bus -> (
      let kotlin =
        Result.bind (Kotlin_sdk.types_of spec) (fun types ->
            Kotlin.files ~component ~types
              ~log_cases:spec.tables.bus_log_cases bus)
      in
      match (Go.files bus, Python.files bus, kotlin) with
      | Ok go, Ok python, Ok kotlin ->
          Ok (Typescript.files bus @ go @ python @ kotlin)
      | go, python, kotlin -> Error (errors go @ errors python @ errors kotlin))
  | Error errors -> Error errors
