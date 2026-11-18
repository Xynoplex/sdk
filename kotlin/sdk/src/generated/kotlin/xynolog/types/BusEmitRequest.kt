// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.ResourceId

/** One event for the bus. `channel` names a channel of the bus registry (specs/src/bus/registry.json) and `payload` must match the schema the registry's `validate` names for it. `scope` publishes a resource-bound broadcast to that resource's subscribers only; everything else is unscoped. `clientId` and `correlationId` are routing facts beside the payload, never inside it. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BusEmitRequest(
    /** A channel of the bus registry. */
    public val channel: String,
    /** The channel's payload, validated against the schema its registry entry names. `_userId` and `_roles` are the gateway's to write: whatever a caller puts there is replaced. */
    public val payload: JsonObject,
    /** The resource scope of a resource-bound broadcast. Publishers of those broadcasts only; a command or request never carries one. */
    @get:JvmExposeBoxed
    public val scope: ResourceId? = null,
    /** The address this request's reply is delivered to: the emit claims `correlationId` for this clientId and the verified principal. Required when `channel` is a registry operation's request and a correlationId is present; ignored otherwise. An empty string counts as absent. */
    public val clientId: String? = null,
    /** Pairs a reply with its request. On a registry operation's request it claims the id: a second claim of a live id is refused with 409. Replies carry it back on the frame, never in the payload. */
    public val correlationId: String? = null,
) {
    /** How Java makes a `BusEmitRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val channel: String,
        private val payload: JsonObject,
    ) {
        private var scope: ResourceId? = null
        private var clientId: String? = null
        private var correlationId: String? = null

        @JvmExposeBoxed
        public fun scope(scope: ResourceId?): Builder = apply { this.scope = scope }

        public fun clientId(clientId: String?): Builder = apply { this.clientId = clientId }
        public fun correlationId(correlationId: String?): Builder = apply { this.correlationId = correlationId }

        public fun build(): BusEmitRequest = BusEmitRequest(channel = channel, payload = payload, scope = scope, clientId = clientId, correlationId = correlationId)
    }

    public companion object {
        /** A builder of a `BusEmitRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(channel: String, payload: JsonObject): Builder = Builder(channel, payload)
    }
}
