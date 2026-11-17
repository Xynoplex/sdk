(* The TypeScript bus authority, in typescript/core/src:

   bus-protocol.ts        EventMap, CHANNEL_SCHEMAS, TRACE_FIELD, CHANNEL_STAMPS
                          and CHANNEL_PAYLOADS
   persisted-events.ts    the persisted-event catalog
   bus-operations.ts      BUS_OPERATIONS, and REPLY_NAMES
   bridged-channels.ts    the broadcasts, and the channels a resource's scope
                          carries
   bus-classification.ts  CHANNEL_ATTRS *)

module R = Tables.Bus_registry

let banner =
  {|// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/bus/registry.json  (channels, payloads, operations)
// Regenerate:  make generate  (codegen/lib/bus/typescript.ml)
// Go counterpart: codegen/lib/bus/go.ml → go/bus
//
// Payload schemas themselves live in the OpenAPI components; the registry
// names which one each channel carries, and every payload type here is
// derived from that. Add or change a channel THERE.

|}

let value_column_schemas = 38
let value_column_operations = 41
let failure_column_operations = 85
let lines = String.concat "\n"
let quoted name = "'" ^ name ^ "'"
let listed names = "[" ^ String.concat ", " (List.map quoted names) ^ "]"

let trailing (docs : R.docs) =
  if docs.trailing = "" then "" else " " ^ docs.trailing

(* Each entry's lead lines, then its own. *)
let entries docs line items =
  List.concat_map (fun item -> (docs item : R.docs).lead @ [ line item ]) items

let schema_type name = "components['schemas']['" ^ name ^ "']"

let payload_type (c : R.channel) =
  match c.payload with
  | Schema { schema; _ } -> schema_type schema
  | Envelope { schema } -> "{ response: " ^ schema_type schema ^ " }"
  | Stored_event { event; enriched; _ } ->
      (if enriched then "EnrichedEvent" else "StoredEvent")
      ^ "<EventOfType<'" ^ event ^ "'>>"
  | Void -> "void"
  | Empty -> "Record<string, never>"

let payload_schema (c : R.channel) =
  match c.payload with
  | Schema { schema; _ } -> "{ payload: '" ^ schema ^ "' }"
  | Envelope { schema } -> "{ response: '" ^ schema ^ "' }"
  | Stored_event { enriched; _ } ->
      "{ payload: '" ^ Registry.stored_event_component ~enriched ^ "' }"
  | Void | Empty -> "{}"

let key column channel = Text.pad ("  '" ^ channel ^ "':") column

let protocol (bus : Registry.t) =
  let reg = bus.registry in
  let channels = List.map bus.channel in
  let event_map =
    entries
      (fun (c : R.channel) -> c.docs)
      (fun c ->
        "  '" ^ c.channel ^ "': " ^ payload_type c ^ ";" ^ trailing c.docs)
      (channels reg.channel_order.event_map)
  in
  let schemas =
    entries
      (fun (c : R.channel) -> c.schema_docs)
      (fun c ->
        key value_column_schemas c.channel
        ^ (match Registry.validate_of c with
          | None -> "null"
          | Some validate -> quoted validate)
        ^ "," ^ trailing c.schema_docs)
      (channels reg.channel_order.schemas)
  in
  let enriched =
    List.filter_map
      (fun (c : R.channel) ->
        match c.payload with
        | Stored_event { enriched = true; _ } -> Some ("  '" ^ c.channel ^ "',")
        | _ -> None)
      reg.channels
  in
  let stamps =
    List.map
      (fun (channel, stamps) ->
        key value_column_schemas channel ^ listed stamps ^ ",")
      bus.stamps
  in
  let payloads =
    List.map
      (fun c -> key value_column_schemas c.R.channel ^ payload_schema c ^ ",")
      (channels reg.channel_order.event_map)
  in
  String.concat ""
    [
      banner;
      {|/**
 * Bus Protocol
 *
 * The complete EventMap for the RxJS EventBus. Every channel name and
 * its payload type is defined here — domain events, commands, reads,
 * results, SSE stream payloads, and Browser UI events. What TypeScript
 * narrows in a payload is bus-refinements.ts's.
 *
 * Organized by flow (verb), then by category within each flow.
 */

import type { components } from './types';
import type { EnrichedEvent, StoredEvent } from './event-base';
import type { EventOfType, PersistedEventType } from './persisted-events';
import type { ChannelRefinements } from './bus-refinements';

/** Each channel's payload as the registry states it. */
export type StatedEventMap = {|};
      lines event_map;
      {|
};

/**
 * The unified EventMap — every channel on the EventBus: each channel's
 * stated payload, or its refinement where bus-refinements.ts narrows it.
 *
 * Convention:
 * - Domain events (past tense): StoredEvent<Interface> — branded types
 * - Annotation-mutating events: EnrichedEvent<Interface> — the stored event
 *   plus the annotation the EventStore attaches before publishing
 * - Commands/reads/results/UI: OpenAPI schema refs — plain strings
 * - void: UI-only signals with no payload
 */
export type EventMap = {
  [K in keyof StatedEventMap]: K extends keyof ChannelRefinements ? ChannelRefinements[K] : StatedEventMap[K];
};

|};
      "export type { AnchorRect } from './bus-ui-types';\n\n";
      reg.docs.event_name;
      "\nexport type EventName = keyof EventMap;\n\n";
      reg.docs.enriched_events;
      "\nexport const ENRICHED_EVENT_TYPES = [\n";
      lines enriched;
      "\n] as const satisfies readonly PersistedEventType[];\n\n";
      "export type EnrichedEventType = typeof ENRICHED_EVENT_TYPES[number];\n\n";
      reg.docs.channel_schemas;
      "\nexport const CHANNEL_SCHEMAS = {";
      lines schemas;
      "\n\
       } as const satisfies Record<EventName, keyof components['schemas'] | \
       null>;\n\n";
      reg.docs.emittable_channel;
      "\nexport type EmittableChannel = {\n";
      "  [K in EventName]: typeof CHANNEL_SCHEMAS[K] extends null ? never : K\n";
      "}[EventName];\n\n";
      Text.doc_comment reg.trace.meaning;
      "\n";
      "export const TRACE_FIELD = '" ^ reg.trace.field ^ "';\n\n";
      {|/**
 * The stamps a gateway puts on a payload (`_userId`, `_roles`) that each
 * channel's payload type declares, and so reads. Any other is the bus's, not
 * the payload's, and is left out of what the SDK delivers.
 */
export const CHANNEL_STAMPS = {
|};
      lines stamps;
      {|
} as const satisfies Record<EventName, readonly string[]>;

/**
 * What each channel's payload is, as a reader holds it: the component schema
 * it is (`payload`), a `{ response }` whose response is one (`response`), or
 * nothing a schema states (`{}`). A stored event is its stored form; what it
 * records is the channel's own. A payload read off the wire with a fault as
 * its schema's, a member it lacks or one that is malformed, is not its
 * channel's.
 */
export const CHANNEL_PAYLOADS = {
|};
      lines payloads;
      "\n\
       } as const satisfies Record<EventName, { readonly payload: keyof \
       components['schemas'] } | { readonly response: keyof \
       components['schemas'] } | Record<string, never>>;\n";
    ]

(* The catalog is the registry's stored-event channels, in their order: the
   payload each names, and the system flag of those that belong to no
   resource. *)
type stored = { event : string; payload : string; system : bool }

let stored (reg : R.t) =
  List.filter_map
    (fun (c : R.channel) ->
      match c.payload with
      | Stored_event { event; payload; system; _ } ->
          Some { event; payload; system }
      | _ -> None)
    reg.channels

let persisted (bus : Registry.t) =
  let stored = stored bus.registry in
  String.concat ""
    [
      banner;
      {|/**
 * Persisted Events
 *
 * The event types that get appended to the JSONL event log, each with the
 * component schema of its payload. The PersistedEvent union derives from this
 * catalog.
 */

import type { components } from './types';
import type { ResourceId } from './identifiers';
import type { EventBase } from './event-base';
import type { EventPayloadRefinements } from './bus-refinements';

/** Each persisted event type and the payload the registry states it carries. */
export type StatedPersistedEventCatalog = {
|};
      lines
        (List.map
           (fun s ->
             "  '" ^ s.event ^ "': " ^ schema_type s.payload ^ ";")
           stored);
      {|
};

/**
 * Each persisted event type and the payload it carries: the stated one, or
 * its refinement where bus-refinements.ts narrows it to this layer's branded
 * types, so consumers read `payload.annotation.id` as `AnnotationId` without
 * an upcast at every seam.
 */
type PersistedEventCatalog = {
  [K in keyof StatedPersistedEventCatalog]: K extends keyof EventPayloadRefinements
    ? EventPayloadRefinements[K]
    : StatedPersistedEventCatalog[K];
};

/** System event types — persisted events that have no resourceId. */
type SystemEventType = |};
      String.concat " | "
        (List.filter_map
           (fun s -> if s.system then Some (quoted s.event) else None)
           stored);
      {|;

/** Extract the concrete persisted event type for a given type string. */
export type EventOfType<K extends keyof PersistedEventCatalog> =
  K extends SystemEventType
    ? EventBase & { type: K; payload: PersistedEventCatalog[K] }
    : EventBase & { type: K; resourceId: ResourceId; payload: PersistedEventCatalog[K] };

/** The union of all persisted event types. Discriminated on `type`. */
export type PersistedEvent = {
  [K in keyof PersistedEventCatalog]: EventOfType<K>
}[keyof PersistedEventCatalog];

export type PersistedEventType = PersistedEvent['type'];

/** Every persisted event type, for code that enumerates them at runtime. */
export const PERSISTED_EVENT_TYPES = [
|};
      lines (List.map (fun s -> "  '" ^ s.event ^ "',") stored);
      {|
] as const satisfies readonly PersistedEventType[];

/** Input type for appendEvent — PersistedEvent without id/timestamp (assigned at persistence time). */
export type EventInput = Omit<PersistedEvent, 'id' | 'timestamp'>;
|};
    ]

let operations (bus : Registry.t) =
  let reg = bus.registry in
  let operations =
    entries
      (fun (o : R.operation) -> o.docs)
      (fun o ->
        Text.pad
          (Text.pad ("  '" ^ o.request ^ "':") value_column_operations
          ^ "{ result: '" ^ o.result ^ "',")
          failure_column_operations
        ^ "failure: '" ^ o.failure ^ "' }," ^ trailing o.docs)
      reg.operations
  in
  let reply_names =
    List.map
      (fun (request, names) ->
        key value_column_operations request ^ listed names ^ ",")
      bus.reply_names
  in
  String.concat ""
    [
      banner;
      {|import type { EventMap, EventName, EmittableChannel } from './bus-protocol';

/**
 * BUS_OPERATIONS — the request/reply operations registry.
 *
 * Each entry declares ONE operation as a triple, so its three facts are
 * stated together rather than maintained independently across call sites:
 *   - the request channel (the key — an `EmittableChannel`),
 *   - the `result` channel (success reply),
 *   - and the `failure` channel.
 *
 * `BridgedChannel` / `BRIDGED_CHANNELS` are DERIVED from this map
 * (bridging.ts): every reply lands in the bridged fan-in set by
 * construction, so "a reply channel forgotten from BRIDGED_CHANNELS" is not
 * representable.
 *
 * `Partial<Record<EmittableChannel, …>>` enforces that every key is a real
 * emittable request. `result`/`failure` stay `EventName` rather than
 * `BridgedChannel` to avoid a circular reference (BridgedChannel derives from
 * this map); the derivation closes the loop instead.
 */
export interface BusOperationSpec {
  result: EventName;
  failure: EventName;
}

export const BUS_OPERATIONS = {|};
      lines operations;
      {|
} as const satisfies Partial<Record<EmittableChannel, BusOperationSpec>>;

/** The request-channel key of a registered operation — what `Bus.request` takes. */
export type BusOperationKey = keyof typeof BUS_OPERATIONS;
|};
      {|
/**
 * REPLY_NAMES — what each operation's reply states beside its `response`.
 *
 * A reply names what it answers for by stating a property of its request
 * again: the annotation or the resource a context was gathered for, the
 * reference a search was for. Whoever answers takes each from the request.
 * Most replies name nothing.
 *
 * Each list is what the reply's component schema requires, without
 * `response`. The generator refuses a name the request's schema does not
 * state, and the `satisfies` below holds each to the TypeScript types of both
 * payloads.
 */
export const REPLY_NAMES = {
|};
      lines reply_names;
      {|
} as const satisfies {
  readonly [Op in BusOperationKey]: readonly (keyof EventMap[Op] &
    keyof EventMap[(typeof BUS_OPERATIONS)[Op]['result'] & EventName])[];
};
|};
    ]

let bridged (bus : Registry.t) =
  let reg = bus.registry in
  let channels list = lines (List.map (fun c -> "  '" ^ c ^ "',") list) in
  String.concat ""
    [
      banner;
      "import type { EventName } from './bus-protocol';\n\n";
      reg.audience.doc;
      "\nexport const BRIDGED_BROADCASTS = [\n";
      channels reg.audience.everyone;
      "\n] as const satisfies readonly EventName[];\n\n";
      {|/**
 * The channels a client receives per RESOURCE SCOPE rather than globally —
 * what `subscribeToResource` joins. `audience: scoped` in the registry.
 */
export const RESOURCE_SCOPED_CHANNELS = [
|};
      channels reg.audience.scoped;
      {|
] as const satisfies readonly EventName[];

/** A channel a resource's scope carries. A read of one names its resource. */
export type ResourceScopedChannel = (typeof RESOURCE_SCOPED_CHANNELS)[number];

/** A channel of no resource's scope: every other channel. */
export type UnscopedChannel = Exclude<EventName, ResourceScopedChannel>;
|};
    ]

let direction : Registry.direction -> string = function
  | Outbound -> "outbound"
  | Inbound -> "inbound"
  | In_process -> "in-process"

let delivery : Registry.delivery -> string = function
  | Positioned -> "positioned"
  | Correlated -> "correlated"
  | Passing -> "passing"

let classification (bus : Registry.t) =
  let reg = bus.registry in
  let attrs =
    List.map
      (fun (a : Registry.attrs) ->
        key value_column_schemas a.channel
        ^ "{ recorded: " ^ string_of_bool a.recorded ^ ", direction: '"
        ^ direction a.direction ^ "'"
        ^ (match a.writes with
          | None -> ""
          | Some writes -> ", writes: " ^ string_of_bool writes)
        ^ (match a.delivery with
          | None -> ""
          | Some d -> ", delivery: '" ^ delivery d ^ "'")
        ^ " },")
      bus.attrs
  in
  String.concat ""
    [
      banner;
      {|import type { EventName } from './bus-protocol';

/** Where a channel sits relative to the hub: emitted toward it, delivered
 *  from it (the fan-in set — BRIDGED_CHANNELS, by construction), or never on
 *  the wire at all. */
export type ChannelDirection = 'outbound' | 'inbound' | 'in-process';

/**
 * A channel's delivery class: what a subscriber is promised about a frame on
 * it when its stream drops, or is handed to another. The promise comes from
 * the frame's identity (protocol/contract/TRANSPORT-CONTRACT.md § Delivery).
 *
 *   positioned — a recorded event delivered on its resource's scope. Its id
 *                is its place in that resource's record: a subscriber that
 *                names the last one it holds is sent what it missed.
 *   correlated — the reply to a claimed request, routed to the client that
 *                asked. Its id is the request's: it is recognised when it
 *                arrives twice, and sent again while it is retained.
 *   passing    — every other frame. Nothing replays it.
 *
 * Derived from the registry's axes, never declared: an operation's replies
 * are correlated; a recorded event whose audience is `scoped` is positioned;
 * everything else that crosses the wire is passing. Who RECEIVES a frame is
 * the audience axis, and a different question.
 */
export type ChannelDelivery = 'positioned' | 'correlated' | 'passing';

export interface ChannelAttrs {
  /** In PERSISTED_EVENT_TYPES — lands in the event log, the system of record. */
  readonly recorded: boolean;
  readonly direction: ChannelDirection;
|};
      (* Every line of the doc indented, an empty last one too. *)
      "  " ^ Text.replace_all ~sub:"\n" ~by:"\n  " reg.effect_.doc;
      {|
  readonly writes?: boolean;
  /** Absent exactly when the channel never crosses the wire (`in-process`). */
  readonly delivery?: ChannelDelivery;
}

export const CHANNEL_ATTRS = {
|};
      lines attrs;
      {|
} as const satisfies Record<EventName, ChannelAttrs>;
|};
    ]

let files bus : Output.file list =
  let at name text = { Output.path = "typescript/core/src/" ^ name; text } in
  [
    at "bus-protocol.ts" (protocol bus);
    at "persisted-events.ts" (persisted bus);
    at "bus-operations.ts" (operations bus);
    at "bridged-channels.ts" (bridged bus);
    at "bus-classification.ts" (classification bus);
  ]
