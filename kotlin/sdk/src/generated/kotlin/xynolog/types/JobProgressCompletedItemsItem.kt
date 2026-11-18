// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCompletedItemsItem(
    /** The item, shown verbatim. */
    public val value: String,
    /** Annotations found for it. */
    public val foundCount: Long,
    /** Annotations actually persisted for it — post-dedupe and post-durability-acknowledgement, so it counts what the event log holds, not what the model proposed. Beside foundCount this is the per-unit yield the sizing work is judged by. Present on flows whose units persist as they complete (a linking job); the tagging flow reports the same fact as byCategory on its result, because its annotations are built after the per-category loop. */
    public val persistedCount: Long? = null,
    /** Present only when pieces of this unit were accepted at the subdivision floor while a count call said more was present. The unit completed, but incompletely — this carries the EVIDENCE (found vs counted, over how many pieces), never a judgment against any expected yield. Absent means complete: genuinely absent, not defaulted. */
    public val underReported: JobProgressCompletedItemsItemUnderReported? = null,
) {
    /** How Java makes a `JobProgressCompletedItemsItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
        private val foundCount: Long,
    ) {
        private var persistedCount: Long? = null
        private var underReported: JobProgressCompletedItemsItemUnderReported? = null

        public fun persistedCount(persistedCount: Long?): Builder = apply { this.persistedCount = persistedCount }
        public fun underReported(underReported: JobProgressCompletedItemsItemUnderReported?): Builder = apply { this.underReported = underReported }

        public fun build(): JobProgressCompletedItemsItem = JobProgressCompletedItemsItem(value = value, foundCount = foundCount, persistedCount = persistedCount, underReported = underReported)
    }

    public companion object {
        /** A builder of a `JobProgressCompletedItemsItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String, foundCount: Long): Builder = Builder(value, foundCount)
    }
}
