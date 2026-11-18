// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Wire format for persisted events delivered over the bus SSE stream (GET /bus/subscribe). Extends StoredEventResponse with optional enrichment fields the EventStore populates from the materialized view at publish time (persistence → view → enrich → notification). Subscribers read the enrichment fields directly to update local caches without an additional fetch. */
@Serializable
@JsonIgnoreUnknownKeys
public data class EnrichedResourceEvent(
    /** Unique event ID (UUID) */
    public val id: String,
    /** Event type (flow verb name, e.g. mark:added) */
    public val type: String,
    /** When the event occurred */
    public val timestamp: String,
    /** DID of the user who triggered the event */
    @get:JvmExposeBoxed
    public val userId: UserId,
    /** Resource this event affects (absent for system events) */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    /** Event schema version */
    public val version: Long,
    /** Event-type-specific payload */
    public val payload: JsonObject,
    public val metadata: EventMetadata,
    /** Populated for events that mutate an annotation (mark:added, mark:body-updated, mark:removed). Carries the post-materialization annotation as it exists in the view, so subscribers can update local caches in-place without refetching. Absent for events that don't touch annotations. */
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
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        public fun annotation(annotation: Annotation?): Builder = apply { this.annotation = annotation }

        public fun build(): EnrichedResourceEvent = EnrichedResourceEvent(id = id, type = type, timestamp = timestamp, userId = userId, resourceId = resourceId, version = version, payload = payload, metadata = metadata, annotation = annotation)
    }

    public companion object {
        /** A builder of a `EnrichedResourceEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: String, type: String, timestamp: String, userId: UserId, version: Long, payload: JsonObject, metadata: EventMetadata): Builder = Builder(id, type, timestamp, userId, version, payload, metadata)
    }
}
