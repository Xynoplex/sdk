(* The cache refresh group: what a client's live queries hold, and what each
   event on the bus, the reopening of a dropped stream and an event that
   cannot be read does to them (protocol/specs/src/client/refresh.json), for
   the Go, Python, TypeScript, Haskell, OCaml and Kotlin SDKs. Table holds the
   table to the registry, the gateway's API and each channel's events; Go,
   Python, Typescript, Haskell, Ocaml and Kotlin write it. *)

module Table = Table
module Go = Go
module Python = Python
module Typescript = Typescript
module Haskell = Haskell
module Ocaml = Ocaml
module Kotlin = Kotlin
module Rust = Rust

let ( let* ) = Result.bind

(* Each GET of the gateway's API, as the table names one: "GET /template". *)
let reads (spec : Spec.t) =
  List.filter_map
    (fun (template, reference) ->
      let file, _ = Decode.resolve reference in
      match List.assoc file spec.path_items with
      | { Openapi.get = Some _; _ } -> Some ("GET " ^ template)
      | { get = None; _ } -> None)
    spec.gateway.paths

let channels ~known (registry : Tables.Bus_registry.t) =
  let delivery = Bus.Registry.delivery_classes registry in
  Required.collect
    (List.map
       (fun (c : Tables.Bus_registry.channel) ->
         Result.map
           (fun event ->
             let payload, enriched, system =
               match c.payload with
               | Stored_event { payload; enriched; system; _ } ->
                   (Some payload, enriched, system)
               | Schema _ | Envelope _ | Void | Empty -> (None, false, false)
             in
             ( c.channel,
               {
                 Table.event;
                 payload;
                 enriched;
                 system;
                 scoped = List.mem c.channel registry.audience.scoped;
                 passing =
                   Hashtbl.find_opt delivery c.channel
                   = Some Bus.Registry.Passing;
               } ))
           (Required.Event.channel ~known c))
       registry.channels)

let context (spec : Spec.t) =
  let registry = spec.tables.bus_registry in
  let* components = Required.collect (Required.components spec) in
  let* derivation =
    Required.Shape.derive
      ~unrecognized:spec.tables.errors_codes.bus_request.unrecognized_failure
      components
  in
  let shapes = derivation.shapes in
  let* channels =
    channels ~known:(fun name -> List.mem_assoc name shapes) registry
  in
  Ok
    {
      Table.requests =
        List.map
          (fun (o : Tables.Bus_registry.operation) -> o.request)
          registry.operations;
      reads = reads spec;
      channels;
      shapes;
      components;
    }

let files ~root:_ (spec : Spec.t) =
  let* context = context spec in
  let* t = Table.derive context spec.tables.client_refresh in
  let* rust = Rust.files spec.tables.client_refresh t in
  let* types = Kotlin_sdk.types_of spec in
  let* kotlin =
    Kotlin_sdk.written ~from_:Table.file (fun () -> Kotlin.file ~types t)
  in
  Ok
    ([ Go.file t; Python.file t; Typescript.file t ]
    @ Haskell.files t
    @ [ Ocaml.file spec.tables.client_refresh; kotlin ]
    @ rust)
