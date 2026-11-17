(* specs/src/bus/registry.json *)

type channel_order = { event_map : string list; schemas : string list }

let channel_order =
  Decode.obj (fun o : channel_order ->
      {
        event_map = Decode.required o "eventMap" (Decode.list Decode.string);
        schemas = Decode.required o "schemas" (Decode.list Decode.string);
      })

(* The lines written before an entry, and the comment after it on its line. *)
type docs = { lead : string list; trailing : string }

let docs =
  Decode.obj (fun o : docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

(* What a channel carries, by its shape. Only a channel that carries a schema
   is validated against one, and then against that schema or none. Only a
   stored event names an event and its payload, and its flags are true or
   absent. *)
type payload =
  | Schema of { schema : string; validate : string option }
  | Envelope of { schema : string }
  | Stored_event of {
      event : string;
      payload : string;
      enriched : bool;
      system : bool;
    }
  | Void
  | Empty

type channel = {
  channel : string;
  payload : payload;
  docs : docs;
  schema_docs : docs;
}

let flag o name =
  Option.is_some
    (Decode.optional o name (fun cursor ->
         if not (Decode.bool cursor) then
           Decode.refuse cursor "a flag is true, or absent"))

let channel_of payload =
  Decode.obj (fun o : channel ->
      {
        channel = Decode.required o "channel" Decode.string;
        payload = payload o;
        docs = Decode.required o "docs" docs;
        schema_docs = Decode.required o "schemaDocs" docs;
      })

let no_validate o = Decode.required o "validate" Decode.null

let channel =
  Decode.variant "shape"
    [
      ( "schema",
        channel_of (fun o ->
            Decode.required o "shape" (Decode.literal "schema");
            Schema
              {
                schema = Decode.required o "schema" Decode.non_empty_string;
                validate =
                  Decode.required o "validate"
                    (Decode.nullable Decode.non_empty_string);
              }) );
      ( "envelope",
        channel_of (fun o ->
            Decode.required o "shape" (Decode.literal "envelope");
            no_validate o;
            Envelope
              { schema = Decode.required o "schema" Decode.non_empty_string })
      );
      ( "storedEvent",
        channel_of (fun o ->
            Decode.required o "shape" (Decode.literal "storedEvent");
            no_validate o;
            Stored_event
              {
                event = Decode.required o "event" Decode.string;
                payload = Decode.required o "payload" Decode.non_empty_string;
                enriched = flag o "enriched";
                system = flag o "system";
              }) );
      ( "void",
        channel_of (fun o ->
            Decode.required o "shape" (Decode.literal "void");
            no_validate o;
            Void) );
      ( "empty",
        channel_of (fun o ->
            Decode.required o "shape" (Decode.literal "empty");
            no_validate o;
            Empty) );
    ]

type operation = {
  request : string;
  result : string;
  failure : string;
  docs : docs;
}

let operation =
  Decode.obj (fun o : operation ->
      {
        request = Decode.required o "request" Decode.string;
        result = Decode.required o "result" Decode.string;
        failure = Decode.required o "failure" Decode.string;
        docs = Decode.required o "docs" docs;
      })

type type_docs = {
  event_name : string;
  enriched_events : string;
  channel_schemas : string;
  emittable_channel : string;
}

let type_docs =
  Decode.obj (fun o : type_docs ->
      {
        event_name = Decode.required o "eventName" Decode.string;
        enriched_events = Decode.required o "enrichedEvents" Decode.string;
        channel_schemas = Decode.required o "channelSchemas" Decode.string;
        emittable_channel = Decode.required o "emittableChannel" Decode.string;
      })

type in_process = { doc : string; channels : string list }

let in_process =
  Decode.obj (fun o : in_process ->
      {
        doc = Decode.required o "doc" Decode.string;
        channels = Decode.required o "channels" (Decode.list Decode.string);
      })

type kind = { doc : string; command : string list; event : string list }

let kind =
  Decode.obj (fun o : kind ->
      {
        doc = Decode.required o "doc" Decode.string;
        command = Decode.required o "command" (Decode.list Decode.string);
        event = Decode.required o "event" (Decode.list Decode.string);
      })

type audience = {
  doc : string;
  everyone : string list;
  scoped : string list;
  declared : string list;
}

let audience =
  Decode.obj (fun o : audience ->
      {
        doc = Decode.required o "doc" Decode.string;
        everyone = Decode.required o "everyone" (Decode.list Decode.string);
        scoped = Decode.required o "scoped" (Decode.list Decode.string);
        declared = Decode.required o "declared" (Decode.list Decode.string);
      })

type effect_ = { doc : string; writes : string list; reads : string list }

let effect_ =
  Decode.obj (fun o : effect_ ->
      {
        doc = Decode.required o "doc" Decode.string;
        writes = Decode.required o "writes" (Decode.list Decode.string);
        reads = Decode.required o "reads" (Decode.list Decode.string);
      })

type trace = { meaning : string; field : string }

let trace =
  Decode.obj (fun o : trace ->
      {
        meaning = Decode.required o "meaning" Decode.non_empty_string;
        field = Decode.required o "field" Decode.string;
      })

type t = {
  comment : string;
  channel_order : channel_order;
  channels : channel list;
  operations : operation list;
  docs : type_docs;
  in_process : in_process;
  kind : kind;
  audience : audience;
  effect_ : effect_;
  trace : trace;
}

let decode =
  Decode.obj (fun o : t ->
      {
        comment = Decode.required o "$comment" Decode.string;
        channel_order = Decode.required o "channelOrder" channel_order;
        channels = Decode.required o "channels" (Decode.list channel);
        operations = Decode.required o "operations" (Decode.list operation);
        docs = Decode.required o "docs" type_docs;
        in_process = Decode.required o "inProcess" in_process;
        kind = Decode.required o "kind" kind;
        audience = Decode.required o "audience" audience;
        effect_ = Decode.required o "effect" effect_;
        trace = Decode.required o "trace" trace;
      })
