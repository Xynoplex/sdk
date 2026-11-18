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
 * One frame of the bus stream, as the `data` line of a `bus-event` message carries it (JSON-serialised on one line). `payload` is the channel's payload as its registry entry declares it. A frame on a scoped subscription carries the scope it was published on; a correlated reply carries the `correlationId` of the request it answers.
 */
@Serializable
public data class BusFrame(
    /**
     * A channel of the bus registry (specs/src/bus/registry.json).
     */
    @SerialName("channel")
    public val channel: String,
    /**
     * The request this frame answers. Present on correlated replies; absent otherwise.
     */
    @SerialName("correlationId")
    public val correlationId: String? = null,
    /**
     * The channel's payload. A replayed persisted event is the stored event itself, whose `metadata.sequenceNumber` the message id carries.
     */
    @SerialName("payload")
    public val payload: JsonObject,
    /**
     * The resource scope the frame was published on. Present exactly when it arrived through a `scoped` entry of the subscription.
     */
    @SerialName("scope")
    @get:JvmExposeBoxed
    public val scope: ResourceId? = null,
) {
    /** How Java makes a `BusFrame`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val channel: String,
        private val payload: JsonObject,
    ) {
        private var correlationId: String? = null
        private var scope: ResourceId? = null

        public fun correlationId(correlationId: String?): Builder {
            this.correlationId = correlationId
            return this
        }

        @JvmExposeBoxed
        public fun scope(scope: ResourceId?): Builder {
            this.scope = scope
            return this
        }

        public fun build(): BusFrame = BusFrame(channel = channel, correlationId = correlationId, payload = payload, scope = scope)
    }

    public companion object {
        /** A builder of a `BusFrame` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(channel: String, payload: JsonObject): Builder = Builder(channel, payload)
    }
}
