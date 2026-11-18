// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Metadata added at persistence time. Part of every StoredEvent. Integrity is provided by git at the commit level (when gitSync is enabled), not by in-event metadata fields. */
@Serializable
@JsonIgnoreUnknownKeys
public data class EventMetadata(
    /** Monotonic position in the event log (ordering authority) */
    public val sequenceNumber: Long,
) {
    /** How Java makes a `EventMetadata`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val sequenceNumber: Long,
    ) {
        public fun build(): EventMetadata = EventMetadata(sequenceNumber = sequenceNumber)
    }

    public companion object {
        /** A builder of a `EventMetadata` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(sequenceNumber: Long): Builder = Builder(sequenceNumber)
    }
}
