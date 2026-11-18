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
 * Result of publishing one event. `subscribers` is the number of observers attached to the target subject at dispatch — the GLOBAL subject for an unscoped emit, the scoped one when `scope` is set. Zero means the signal reached nobody: /bus/subscribe enforces no channel allowlist and the emit handler publishes unconditionally, so a client can emit a channel no participant subscribes to and otherwise receive a clean 202 with no way to tell. Deliberately NOT named `delivered`: this is the count at dispatch, and a subscriber may still drop the frame downstream, so the field is named after what the server can actually observe.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class BusEmitAccepted(
    /**
     * Observers on the target subject when the event was dispatched. ABSENT means the gateway could not count: under a broker signal plane (the KnowledgeBase document's `spec.messaging.signal.type: nats`) the event is published to a fabric whose observers the gateway cannot see. The one zero a broker plane states is a registry operation's request with a `correlationId` that reached nobody, which the broker itself reports (no responders). Never defaulted: a zero here is the claim that nobody was listening, and a gateway that did not observe that never makes it.
     */
    @SerialName("subscribers")
    public val subscribers: Long? = null,
) {
    /** How Java makes a `BusEmitAccepted`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var subscribers: Long? = null

        public fun subscribers(subscribers: Long?): Builder {
            this.subscribers = subscribers
            return this
        }

        public fun build(): BusEmitAccepted = BusEmitAccepted(subscribers = subscribers)
    }

    public companion object {
        /** A builder of a `BusEmitAccepted` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
