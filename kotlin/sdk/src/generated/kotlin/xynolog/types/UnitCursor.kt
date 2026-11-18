// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/**
 * The furthest a single unit got, and what it had counted when it got there. A unit left partway is resumed from its cursor rather than redone. A finished unit keeps its cursor: `next` at the length of the text, `size` the size its last piece was cut at, and its final `found`, `emitted` and `errors`, so that an attempt that skips the unit still counts it. A cursor never says a unit is finished, wherever it stands: `completedUnits` does. A unit is an entity type for a linking job, a category for a tagging job, and the job's own motivation for every other — which is why a unit-grain checkpoint alone is too coarse: those three have exactly one unit, so nothing could be recorded until the whole document was done.
 *
 * MERGE IS MONOTONE PER UNIT, not a union. `completedUnits` is a set and converges under concurrent snapshots because a set only grows; a cursor converges only if a stale snapshot can never move it backward.
 *
 * IT CARRIES THE UNIT'S RUNNING TALLIES TOO, and they are required. A resumed unit counts only the chunks it actually runs, so without them a retry's terminal record reports the remainder of the document as if it were the whole — measured at a `found` of 19 where the document yielded 25. The position and the tallies are ONE observation of the same committed chunk; splitting them would let a resume take the saving and still report a number nobody can trust.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class UnitCursor(
    /** Unicode code points of the text consumed once the last COMMITTED chunk completed — the resume position, and the length of the text for a unit whose last chunk it was. Deliberately the chunk's `next`, never its `at`: the checkpoint must not lead the log, so it records where a chunk that is already durable ended, not where the in-flight one began. Recording `at` would make a resume re-run the chunk it already paid for. */
    public val next: Long,
    /** The token size that last committed chunk was cut at — the calibration the attempt paid for over the chunks before it. A resume seeds from this and then takes ONE adaptive step, as if the last outcome were a failure, which it was: the job died. Seeding alone would re-cut the failing piece identically; opening at the default would discard the calibration. */
    public val size: Long,
    /** Items detection has returned for this unit through the last committed chunk — the numerator a resumed attempt continues from rather than restarting at zero. Counts what the model reported, before dedupe. */
    public val found: Long,
    /** Annotations actually committed for this unit through the last committed chunk, after dedupe. With `found` and `errors` it is what the job's terminal result reports, so a resumed unit seeds all three and its record describes the whole document rather than one attempt's share. */
    public val emitted: Long,
    /** Items detection returned for this unit through the last committed chunk that could not be anchored in the text. Carried with the other two tallies so that a resumed job reports the whole document's, and not only its last attempt's. */
    public val errors: Long,
) {
    /** How Java makes a `UnitCursor`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val next: Long,
        private val size: Long,
        private val found: Long,
        private val emitted: Long,
        private val errors: Long,
    ) {
        public fun build(): UnitCursor = UnitCursor(next = next, size = size, found = found, emitted = emitted, errors = errors)
    }

    public companion object {
        /** A builder of a `UnitCursor` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(next: Long, size: Long, found: Long, emitted: Long, errors: Long): Builder = Builder(next, size, found, emitted, errors)
    }
}
