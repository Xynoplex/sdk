// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** A persisted event as a history reply carries it: the stored event, and the agent its `userId` identifies. The agent is derived when the reply is made — the DID read into a Person or a Software agent, and a Person's name filled in from the knowledge base's profiles — and is stored nowhere. A Person the record does not name carries no `name`. */
@Serializable
@JsonIgnoreUnknownKeys
public data class AttributedEvent(
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
    public val agent: Agent,
) {
    /** How Java makes a `AttributedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val type: String,
        private val timestamp: String,
        private val userId: UserId,
        private val version: Long,
        private val payload: JsonObject,
        private val metadata: EventMetadata,
        private val agent: Agent,
    ) {
        private var resourceId: ResourceId? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        public fun build(): AttributedEvent = AttributedEvent(id = id, type = type, timestamp = timestamp, userId = userId, resourceId = resourceId, version = version, payload = payload, metadata = metadata, agent = agent)
    }

    public companion object {
        /** A builder of a `AttributedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: String, type: String, timestamp: String, userId: UserId, version: Long, payload: JsonObject, metadata: EventMetadata, agent: Agent): Builder = Builder(id, type, timestamp, userId, version, payload, metadata, agent)
    }
}
