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
 * One event for the bus. `channel` names a channel of the bus registry (specs/src/bus/registry.json) and `payload` must match the schema the registry's `validate` names for it. `scope` publishes a resource-bound broadcast to that resource's subscribers only; everything else is unscoped. `clientId` and `correlationId` are routing facts beside the payload, never inside it.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class BusEmitRequest(
    /**
     * A channel of the bus registry.
     */
    @SerialName("channel")
    public val channel: String,
    /**
     * The channel's payload, validated against the schema its registry entry names. `_userId` and `_roles` are the gateway's to write: whatever a caller puts there is replaced.
     */
    @SerialName("payload")
    public val payload: JsonObject,
    /**
     * The resource scope of a resource-bound broadcast. Publishers of those broadcasts only; a command or request never carries one.
     */
    @SerialName("scope")
    @get:JvmExposeBoxed
    public val scope: ResourceId? = null,
    /**
     * The address this request's reply is delivered to: the emit claims `correlationId` for this clientId and the verified principal. Required when `channel` is a registry operation's request and a correlationId is present; ignored otherwise. An empty string counts as absent.
     */
    @SerialName("clientId")
    public val clientId: String? = null,
    /**
     * Pairs a reply with its request. On a registry operation's request it claims the id: a second claim of a live id is refused with 409. Replies carry it back on the frame, never in the payload.
     */
    @SerialName("correlationId")
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
        public fun scope(scope: ResourceId?): Builder {
            this.scope = scope
            return this
        }

        public fun clientId(clientId: String?): Builder {
            this.clientId = clientId
            return this
        }

        public fun correlationId(correlationId: String?): Builder {
            this.correlationId = correlationId
            return this
        }

        public fun build(): BusEmitRequest = BusEmitRequest(channel = channel, payload = payload, scope = scope, clientId = clientId, correlationId = correlationId)
    }

    public companion object {
        /** A builder of a `BusEmitRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(channel: String, payload: JsonObject): Builder = Builder(channel, payload)
    }
}
