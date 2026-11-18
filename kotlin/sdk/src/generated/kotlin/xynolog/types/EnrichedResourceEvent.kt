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
 * Wire format for persisted events delivered over the bus SSE stream (GET /bus/subscribe). Extends StoredEventResponse with optional enrichment fields the EventStore populates from the materialized view at publish time (persistence → view → enrich → notification). Subscribers read the enrichment fields directly to update local caches without an additional fetch.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class EnrichedResourceEvent(
    /**
     * Unique event ID (UUID)
     */
    @SerialName("id")
    public val id: String,
    /**
     * Event type (flow verb name, e.g. mark:added)
     */
    @SerialName("type")
    public val type: String,
    /**
     * When the event occurred
     */
    @SerialName("timestamp")
    public val timestamp: String,
    /**
     * DID of the user who triggered the event
     */
    @SerialName("userId")
    @get:JvmExposeBoxed
    public val userId: UserId,
    /**
     * Resource this event affects (absent for system events)
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    /**
     * Event schema version
     */
    @SerialName("version")
    public val version: Long,
    /**
     * Event-type-specific payload
     */
    @SerialName("payload")
    public val payload: JsonObject,
    @SerialName("metadata")
    public val metadata: EventMetadata,
    /**
     * Populated for events that mutate an annotation (mark:added, mark:body-updated, mark:removed). Carries the post-materialization annotation as it exists in the view, so subscribers can update local caches in-place without refetching. Absent for events that don't touch annotations.
     */
    @SerialName("annotation")
    public val annotation: Annotation? = null,
) {
    /** How Java makes a `EnrichedResourceEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val type: String,
        private val timestamp: String,
        private val userId: UserId,
        private val version: Long,
        private val payload: JsonObject,
        private val metadata: EventMetadata,
    ) {
        private var resourceId: ResourceId? = null
        private var annotation: Annotation? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder {
            this.resourceId = resourceId
            return this
        }

        public fun annotation(annotation: Annotation?): Builder {
            this.annotation = annotation
            return this
        }

        public fun build(): EnrichedResourceEvent = EnrichedResourceEvent(id = id, type = type, timestamp = timestamp, userId = userId, resourceId = resourceId, version = version, payload = payload, metadata = metadata, annotation = annotation)
    }

    public companion object {
        /** A builder of a `EnrichedResourceEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: String, type: String, timestamp: String, userId: UserId, version: Long, payload: JsonObject, metadata: EventMetadata): Builder = Builder(id, type, timestamp, userId, version, payload, metadata)
    }
}
