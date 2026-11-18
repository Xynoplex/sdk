// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Present only when pieces of this unit were accepted at the subdivision floor while a count call said more was present. The unit completed, but incompletely — this carries the EVIDENCE (found vs counted, over how many pieces), never a judgment against any expected yield. Absent means complete: genuinely absent, not defaulted. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCompletedItemsItemUnderReported(
    /** Floor-accepted pieces in this unit. */
    public val pieces: Long,
    /** Annotations extraction did find on those pieces — every span write-time-verified. */
    public val found: Long,
    /** Mentions the count calls reported across those pieces (approximate by nature). */
    public val counted: Long,
) {
    /** How Java makes a `JobProgressCompletedItemsItemUnderReported`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val pieces: Long,
        private val found: Long,
        private val counted: Long,
    ) {
        public fun build(): JobProgressCompletedItemsItemUnderReported = JobProgressCompletedItemsItemUnderReported(pieces = pieces, found = found, counted = counted)
    }

    public companion object {
        /** A builder of a `JobProgressCompletedItemsItemUnderReported` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(pieces: Long, found: Long, counted: Long): Builder = Builder(pieces, found, counted)
    }
}
