(* The required group: what each component schema requires of a value, the
   table every SDK holds a reply to before it reads it. Shape derives it, and
   Event what an event on each bus channel is; Table, Typescript, Python and
   Haskell write it; Go holds it to what package api declares. *)

module Shape = Shape
module Event = Event
module Table = Table
module Typescript = Typescript
module Python = Python
module Haskell = Haskell
module Go = Go
module Ocaml = Ocaml
module Csharp = Csharp

let refusal file pointer message = { Decode.file; pointer; message }

(* Each component the gateway's document names: its name, its file and its
   schema. *)
let components (spec : Spec.t) =
  List.map
    (fun (name, (reference : Decode.reference)) ->
      match Decode.resolve reference with
      | file, "" -> (
          match List.assoc_opt file spec.schemas with
          | Some schema -> Ok (name, file, schema)
          | None ->
              Error
                (refusal reference.file reference.pointer
                   (Printf.sprintf "names %s, which is no JSON Schema"
                      reference.target)))
      | _ ->
          Error
            (refusal reference.file reference.pointer
               (Printf.sprintf "names %s, a place within a file"
                  reference.target)))
    spec.gateway.components.schemas

(* Each gateway operation's reply: the schema of its one successful
   response's one content, by its operationId, capitalized. *)
let replies (spec : Spec.t) (derivation : Shape.t) =
  List.concat_map
    (fun (_, (reference : Decode.reference)) ->
      let file, _ = Decode.resolve reference in
      let item = List.assoc file spec.path_items in
      List.filter_map
        (fun (method_, operation) ->
          Option.map
            (fun (operation : Openapi.operation) ->
              let at = "/" ^ method_ in
              let name = String.capitalize_ascii operation.operation_id in
              match
                List.filter
                  (fun (status, _) -> String.starts_with ~prefix:"2" status)
                  operation.responses
              with
              | [
               ( status,
                 Openapi.Inline { content = Some [ (media, content) ]; _ } );
              ] ->
                  Result.map
                    (fun shape -> (name, shape))
                    (derivation.inline ~file
                       ~pointer:
                         (Printf.sprintf "%s/responses/%s/content/%s/schema" at
                            status (Shape.token media))
                       content.schema)
              | [ (status, Openapi.Inline _) ] ->
                  Error
                    (refusal file
                       (at ^ "/responses/" ^ status)
                       "is a success with no one content to hold a reply to")
              | [ (status, Openapi.Ref _) ] ->
                  Error
                    (refusal file
                       (at ^ "/responses/" ^ status)
                       "is a success stated elsewhere, which the table does \
                        not read")
              | _ ->
                  Error
                    (refusal file (at ^ "/responses")
                       "states no one success to hold a reply to"))
            operation)
        [ ("get", item.get); ("put", item.put); ("post", item.post) ])
    spec.gateway.paths

let collect results =
  List.fold_right
    (fun result collected ->
      match (result, collected) with
      | Ok value, Ok values -> Ok (value :: values)
      | Ok _, Error errors -> Error errors
      | Error error, Ok _ -> Error [ error ]
      | Error error, Error errors -> Error (error :: errors))
    results (Ok [])

let declared ~root =
  List.concat_map
    (fun file ->
      Go.declared
        (In_channel.with_open_bin
           (Filename.concat root file)
           In_channel.input_all))
    Go.declaring

(* What each component requires, by the component's name. *)
let derive (spec : Spec.t) =
  Result.bind
    (collect (components spec))
    (Shape.derive
       ~unrecognized:spec.tables.errors_codes.bus_request.unrecognized_failure)

let files ~root (spec : Spec.t) =
  let ( let* ) = Result.bind in
  let* derivation = derive spec in
  let shapes = derivation.shapes in
  let known name = List.mem_assoc name shapes in
  let* channels =
    collect
      (List.map
         (fun (c : Tables.Bus_registry.channel) ->
           Result.map (fun shape -> (c.channel, shape)) (Event.channel ~known c))
         spec.tables.bus_registry.channels)
  in
  let* http = collect (replies spec derivation) in
  let* csharp = Csharp.file derivation spec.tables.bus_registry in
  match Go.check ~declared:(declared ~root) shapes with
  | [] ->
      Ok
        (Table.files shapes
        @ [
            Typescript.file shapes;
            Python.file shapes;
            Haskell.file ~shapes ~channels ~http;
            csharp;
          ]
        @ Ocaml.files shapes)
  | refusals -> Error refusals
