/**
 * The channels a transport bridges into a client's bus, derived from the
 * registry's operations and its broadcasts (bus-operations.ts,
 * bridged-channels.ts), and whether a channel is carried on a resource's
 * scope.
 */

import type { EventName } from './bus-protocol';
import { BUS_OPERATIONS } from './bus-operations';
import {
  BRIDGED_BROADCASTS,
  RESOURCE_SCOPED_CHANNELS,
  type ResourceScopedChannel,
} from './bridged-channels';

// Every operation's result + failure channel bridges, by construction. Type and runtime are derived from the same `BUS_OPERATIONS`.

type OpSpecs = (typeof BUS_OPERATIONS)[keyof typeof BUS_OPERATIONS];

/** The union of every reply channel declared in the registry. */
type RegistryReply = OpSpecs['result'] | OpSpecs['failure'];

// Iterate by typed key so each op's literal reply types survive — the element
// type stays `RegistryReply` (no widening to `EventName`), so the composed
// array is `BridgedChannel[]` with no narrowing assertion. The runtime proof
// that this derived set is exactly the intended one is the equality test in
// __tests__/bus-invariants.test.ts.
const REGISTRY_REPLIES = (
  Object.keys(BUS_OPERATIONS) as (keyof typeof BUS_OPERATIONS)[]
).flatMap((key) => {
  const op = BUS_OPERATIONS[key];
  return [op.result, op.failure];
});

/**
 * BRIDGED_CHANNELS
 *
 * The set of bus channels that any concrete transport bridges into the
 * caller-supplied bus via `bridgeInto`. Transport-neutral: every concrete
 * `ITransport` shares the same set; HTTP delivers them via SSE, in-process
 * transports forward them directly from the local actor bus.
 *
 * This is the *fan-in* set — channels for events the transport receives and
 * pushes onto the client's bus. It is not the same as the channels the client
 * emits (which is open-ended).
 *
 * It is DERIVED, not hand-listed: the request/reply replies come from
 * `BUS_OPERATIONS` (bus-operations.ts), so no operation's reply can be
 * forgotten here. The only hand-maintained part is `BRIDGED_BROADCASTS`: the
 * genuine non-request/reply minority (lifecycle events and UI/infra signals
 * that no single requester owns).
 *
 * Resource-scoped channels (joined/left via `subscribeToResource`) are tracked
 * separately by transports that care about scope (HTTP).
 */
export const BRIDGED_CHANNELS: readonly BridgedChannel[] = [
  ...REGISTRY_REPLIES,
  ...BRIDGED_BROADCASTS,
];

/**
 * The SUBSCRIBE-side subset of `EventName` — the channels a client can receive
 * over a concrete transport. See the family note on `EventName` in
 * bus-protocol.ts (emit on an `EmittableChannel`, subscribe on a `BridgedChannel`).
 */
export type BridgedChannel =
  RegistryReply | (typeof BRIDGED_BROADCASTS)[number];

const SCOPED: ReadonlySet<EventName> = new Set(RESOURCE_SCOPED_CHANNELS);

/** Whether `channel` is delivered on a resource's scope. */
export function isResourceScopedChannel(
  channel: EventName,
): channel is ResourceScopedChannel {
  return SCOPED.has(channel);
}
