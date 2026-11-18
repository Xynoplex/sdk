// ⚠ GENERATED FILE — do not edit.
//
// Authority:   protocol/specs/src/bus/registry.json  (channels, payloads, operations)
// Regenerate:  make generate  (codegen/lib/bus/typescript.ml)
// Go counterpart: codegen/lib/bus/go.ml → go/bus
//
// Payload schemas themselves live in the OpenAPI components; the registry
// names which one each channel carries, and every payload type here is
// derived from that. Add or change a channel THERE.

import type { EventName } from './bus-protocol';

/**
 * WHO receives a wire-crossing channel — independent of `kind` and of
 * `recorded`. An OPERATION's channels are absent: a request reaches the one
 * service that answers it, and a reply is correlated-addressed to its owner.
 *
 * - everyone — every full client subscribes, with every operation's reply
 *   channels (derives BRIDGED_CHANNELS)
 * - scoped — delivered to clients that joined the frame's RESOURCE scope
 *   (derives RESOURCE_SCOPED_CHANNELS)
 * - declared — only clients whose manifest names it: workers, sidecars, and the
 *   gateway's own handlers
 */
export const BRIDGED_BROADCASTS = [
  'job:report-progress',
  'job:complete',
  'job:fail',
  'smelt:settled',
  'frame:entity-type-added',
  'frame:tag-schema-added',
  'yield:created',
  'yield:updated',
  'yield:cloned',
  'yield:moved',
  'beckon:focus',
  'beckon:sparkle',
  'bus:resume-gap',
  'browse:resource-open',
  'browse:resource-viewed',
  'session:joined',
  'session:left',
  'browse:click',
] as const satisfies readonly EventName[];

/**
 * The channels a client receives per RESOURCE SCOPE rather than globally —
 * what `subscribeToResource` joins. `audience: scoped` in the registry.
 */
export const RESOURCE_SCOPED_CHANNELS = [
  'mark:body-updated',
  'yield:representation-added',
  'yield:representation-removed',
  'mark:added',
  'mark:removed',
  'mark:entity-tag-added',
  'mark:entity-tag-removed',
  'mark:archived',
  'mark:unarchived',
  'job:started',
  'job:assigned',
  'job:completed',
  'job:failed',
] as const satisfies readonly EventName[];

/** A channel a resource's scope carries. A read of one names its resource. */
export type ResourceScopedChannel = (typeof RESOURCE_SCOPED_CHANNELS)[number];

/** A channel of no resource's scope: every other channel. */
export type UnscopedChannel = Exclude<EventName, ResourceScopedChannel>;
