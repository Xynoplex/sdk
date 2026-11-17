// The component a recorded event is, by its channel's registry entry. One
// derivation, which every generator that names the payload of a `storedEvent`
// channel asks: typescript/scripts/generators/cache-refresh-table.mjs for the ways
// the client's refresh table reads in it. The bus group derives the same, in
// codegen/lib/bus/registry.ml, for every SDK's bus types and for the
// shape every SDK holds a channel's payload to (codegen/lib/required).

/** The component an event on the `storedEvent` channel `entry` is: enriched where the registry says its events are. */
export const storedEventComponent = (entry) => (entry.enriched === true ? 'EnrichedResourceEvent' : 'StoredEventResponse');
