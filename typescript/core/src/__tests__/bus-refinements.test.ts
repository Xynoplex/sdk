/**
 * Each refinement in bus-refinements.ts names a channel or a persisted event
 * of the registry, and narrows the payload the registry states for it. Both
 * are held at compile time: `tsc --noEmit` refuses this file when a
 * refinement names nothing, or when it widens or changes its payload.
 */

import { describe, expect, it } from 'vitest';
import type {
  ChannelRefinements,
  EventPayloadRefinements,
} from '../bus-refinements';
import type { StatedEventMap } from '../bus-protocol';
import type { StatedPersistedEventCatalog } from '../persisted-events';

/** The keys of `Refinements` that name nothing stated, or do not narrow what is. */
type Unrefining<Refinements, Stated> = {
  [K in keyof Refinements]: K extends keyof Stated
    ? Refinements[K] extends Stated[K]
      ? never
      : K
    : K;
}[keyof Refinements];

const channelsRefined: [
  Unrefining<ChannelRefinements, StatedEventMap>,
] extends [never]
  ? true
  : false = true;
const eventsRefined: [
  Unrefining<EventPayloadRefinements, StatedPersistedEventCatalog>,
] extends [never]
  ? true
  : false = true;

describe('the bus refinements', () => {
  it('each names a channel and narrows its payload', () => {
    expect(channelsRefined).toBe(true);
  });

  it('each names a persisted event and narrows its payload', () => {
    expect(eventsRefined).toBe(true);
  });
});
