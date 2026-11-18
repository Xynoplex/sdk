// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * A page of one stream's events from one sequence number, inclusive, in log order, and the sequence number of the stream's last event: the Archivist's answer to `GET /events/{resourceId}`.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class ArchivistEventsResponse(
    @SerialName("events")
    public val events: kotlin.collections.List<StoredEventResponse>,
    /**
     * The sequence number of the stream's last event when it was read: 0 for a stream with none. More events follow the page while its last event's number is below it.
     */
    @SerialName("lastSequence")
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
