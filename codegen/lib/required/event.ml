(* What an event on a bus channel is, as every reader of one holds it: the
   shape of a channel's payload. *)

module R = Tables.Bus_registry

(* What a channel's payload must be. A channel that carries a component is
   held to it; an envelope is an object holding only its response; an empty
   or void payload is an object with no members. *)
let channel ~known (c : R.channels_item) =
  let named name =
    if known name then Ok (Shape.Ref name)
    else
      Error
        {
          Decode.file = Bus.Registry.file;
          pointer = "/channels";
          message =
            Printf.sprintf "%S carries %s, which is no component"
              (Bus.Registry.name c) name;
        }
  in
  match c with
  | Schema { schema; _ } -> named schema
  | Stored_event { enriched; _ } ->
      named
        (Bus.Registry.stored_event_component ~enriched:(enriched = Some true))
  | Envelope { schema; _ } ->
      Result.map
        (fun response ->
          Shape.Shape
            {
              Shape.empty with
              kinds = Some [ Object ];
              required = Some [ "response" ];
              members = [ ("response", response) ];
              closed = Some [ "response" ];
            })
        (named schema)
  | Void _ | Empty _ ->
      Ok
        (Shape.Shape
           { Shape.empty with kinds = Some [ Object ]; closed = Some [] })
