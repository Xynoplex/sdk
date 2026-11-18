// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A page of one stream's events from one sequence number, inclusive, in log order, and the sequence number of the stream's last event: the Archivist's answer to `GET /events/{resourceId}`. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ArchivistEventsResponse(
    public val events: kotlin.collections.List<StoredEventResponse>,
    /** The sequence number of the stream's last event when it was read: 0 for a stream with none. More events follow the page while its last event's number is below it. */
    public val lastSequence: Long,
) {
    /** How Java makes a `ArchivistEventsResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val events: kotlin.collections.List<StoredEventResponse>,
        private val lastSequence: Long,
    ) {
        public fun build(): ArchivistEventsResponse = ArchivistEventsResponse(events = events, lastSequence = lastSequence)
    }

    public companion object {
        /** A builder of a `ArchivistEventsResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(events: kotlin.collections.List<StoredEventResponse>, lastSequence: Long): Builder = Builder(events, lastSequence)
    }
}
