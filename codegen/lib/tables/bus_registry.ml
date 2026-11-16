(* specs/src/bus/registry.json *)

type channel_order = { event_map : string list; schemas : string list }

let channel_order =
  Decode.obj (fun o : channel_order ->
      {
        event_map = Decode.required o "eventMap" (Decode.list Decode.string);
        schemas = Decode.required o "schemas" (Decode.list Decode.string);
      })

type docs = { lead : string list; trailing : string }

let docs =
  Decode.obj (fun o : docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type schema_docs = { lead : string list; trailing : string }

let schema_docs =
  Decode.obj (fun o : schema_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_stored_event = {
  channel : string;
  event : string;
  payload : string;
  validate : unit;
  docs : docs;
  schema_docs : schema_docs;
  enriched : bool option;
  ts_refinement : string option;
  system : bool option;
}

let channel_stored_event =
  Decode.obj (fun o : channel_stored_event ->
      Decode.required o "shape" (Decode.literal "storedEvent");
      {
        channel = Decode.required o "channel" Decode.string;
        event = Decode.required o "event" Decode.string;
        payload = Decode.required o "payload" Decode.string;
        validate = Decode.required o "validate" Decode.null;
        docs = Decode.required o "docs" docs;
        schema_docs = Decode.required o "schemaDocs" schema_docs;
        enriched = Decode.optional o "enriched" Decode.bool;
        ts_refinement = Decode.optional o "tsRefinement" Decode.string;
        system = Decode.optional o "system" Decode.bool;
      })

type channel_schema_docs = { lead : string list; trailing : string }

let channel_schema_docs =
  Decode.obj (fun o : channel_schema_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_schema_schema_docs = { lead : string list; trailing : string }

let channel_schema_schema_docs =
  Decode.obj (fun o : channel_schema_schema_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_schema = {
  channel : string;
  schema : string;
  validate : string option;
  docs : channel_schema_docs;
  schema_docs : channel_schema_schema_docs;
  ts_refinement : string option;
}

let channel_schema =
  Decode.obj (fun o : channel_schema ->
      Decode.required o "shape" (Decode.literal "schema");
      {
        channel = Decode.required o "channel" Decode.string;
        schema = Decode.required o "schema" Decode.string;
        validate = Decode.required o "validate" (Decode.nullable Decode.string);
        docs = Decode.required o "docs" channel_schema_docs;
        schema_docs = Decode.required o "schemaDocs" channel_schema_schema_docs;
        ts_refinement = Decode.optional o "tsRefinement" Decode.string;
      })

type channel_void_docs = { lead : Decode.nothing list; trailing : string }

let channel_void_docs =
  Decode.obj (fun o : channel_void_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.nothing);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_void_schema_docs = {
  lead : Decode.nothing list;
  trailing : string;
}

let channel_void_schema_docs =
  Decode.obj (fun o : channel_void_schema_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.nothing);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_void = {
  channel : string;
  validate : unit;
  docs : channel_void_docs;
  schema_docs : channel_void_schema_docs;
}

let channel_void =
  Decode.obj (fun o : channel_void ->
      Decode.required o "shape" (Decode.literal "void");
      {
        channel = Decode.required o "channel" Decode.string;
        validate = Decode.required o "validate" Decode.null;
        docs = Decode.required o "docs" channel_void_docs;
        schema_docs = Decode.required o "schemaDocs" channel_void_schema_docs;
      })

type channel_envelope_docs = { lead : string list; trailing : string }

let channel_envelope_docs =
  Decode.obj (fun o : channel_envelope_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_envelope_schema_docs = {
  lead : Decode.nothing list;
  trailing : string;
}

let channel_envelope_schema_docs =
  Decode.obj (fun o : channel_envelope_schema_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.nothing);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_envelope = {
  channel : string;
  schema : string;
  validate : unit;
  docs : channel_envelope_docs;
  schema_docs : channel_envelope_schema_docs;
}

let channel_envelope =
  Decode.obj (fun o : channel_envelope ->
      Decode.required o "shape" (Decode.literal "envelope");
      {
        channel = Decode.required o "channel" Decode.string;
        schema = Decode.required o "schema" Decode.string;
        validate = Decode.required o "validate" Decode.null;
        docs = Decode.required o "docs" channel_envelope_docs;
        schema_docs =
          Decode.required o "schemaDocs" channel_envelope_schema_docs;
      })

type channel_empty_docs = { lead : string list; trailing : string }

let channel_empty_docs =
  Decode.obj (fun o : channel_empty_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_empty_schema_docs = {
  lead : Decode.nothing list;
  trailing : string;
}

let channel_empty_schema_docs =
  Decode.obj (fun o : channel_empty_schema_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.nothing);
        trailing = Decode.required o "trailing" Decode.string;
      })

type channel_empty = {
  channel : string;
  validate : unit;
  docs : channel_empty_docs;
  schema_docs : channel_empty_schema_docs;
}

let channel_empty =
  Decode.obj (fun o : channel_empty ->
      Decode.required o "shape" (Decode.literal "empty");
      {
        channel = Decode.required o "channel" Decode.string;
        validate = Decode.required o "validate" Decode.null;
        docs = Decode.required o "docs" channel_empty_docs;
        schema_docs = Decode.required o "schemaDocs" channel_empty_schema_docs;
      })

type channel =
  | Stored_event of channel_stored_event
  | Schema of channel_schema
  | Void of channel_void
  | Envelope of channel_envelope
  | Empty of channel_empty

let channel =
  Decode.variant "shape"
    [
      ("storedEvent", fun c -> (Stored_event (channel_stored_event c) : channel));
      ("schema", fun c -> (Schema (channel_schema c) : channel));
      ("void", fun c -> (Void (channel_void c) : channel));
      ("envelope", fun c -> (Envelope (channel_envelope c) : channel));
      ("empty", fun c -> (Empty (channel_empty c) : channel));
    ]

type operation_docs = { lead : string list; trailing : string }

let operation_docs =
  Decode.obj (fun o : operation_docs ->
      {
        lead = Decode.required o "lead" (Decode.list Decode.string);
        trailing = Decode.required o "trailing" Decode.string;
      })

type operation = {
  request : string;
  result : string;
  failure : string;
  docs : operation_docs;
}

let operation =
  Decode.obj (fun o : operation ->
      {
        request = Decode.required o "request" Decode.string;
        result = Decode.required o "result" Decode.string;
        failure = Decode.required o "failure" Decode.string;
        docs = Decode.required o "docs" operation_docs;
      })

type preamble = {
  protocol_header : string;
  event_map_tail : Decode.nothing list;
  schemas_tail : Decode.nothing list;
  operations_header : string;
  operations_inner_tail : Decode.nothing list;
  operations_footer : string;
  bridged_header : string;
  bridged_derivation : string;
}

let preamble =
  Decode.obj (fun o : preamble ->
      {
        protocol_header = Decode.required o "protocolHeader" Decode.string;
        event_map_tail =
          Decode.required o "eventMapTail" (Decode.list Decode.nothing);
        schemas_tail =
          Decode.required o "schemasTail" (Decode.list Decode.nothing);
        operations_header = Decode.required o "operationsHeader" Decode.string;
        operations_inner_tail =
          Decode.required o "operationsInnerTail" (Decode.list Decode.nothing);
        operations_footer = Decode.required o "operationsFooter" Decode.string;
        bridged_header = Decode.required o "bridgedHeader" Decode.string;
        bridged_derivation = Decode.required o "bridgedDerivation" Decode.string;
      })

type docs_2 = {
  event_name : string;
  enriched_events : string;
  channel_schemas : string;
  emittable_channel : string;
}

let docs_2 =
  Decode.obj (fun o : docs_2 ->
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
        meaning = Decode.required o "meaning" Decode.string;
        field = Decode.required o "field" Decode.string;
      })

type t = {
  comment : string;
  channel_order : channel_order;
  channels : channel list;
  operations : operation list;
  preamble : preamble;
  docs : docs_2;
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
        preamble = Decode.required o "preamble" preamble;
        docs = Decode.required o "docs" docs_2;
        in_process = Decode.required o "inProcess" in_process;
        kind = Decode.required o "kind" kind;
        audience = Decode.required o "audience" audience;
        effect_ = Decode.required o "effect" effect_;
        trace = Decode.required o "trace" trace;
      })
