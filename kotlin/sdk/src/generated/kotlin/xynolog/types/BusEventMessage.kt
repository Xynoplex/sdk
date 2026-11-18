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
 * A bus frame on the stream: `event: bus-event`, an `id:` line, and one `data:` line holding the JSON-serialised BusFrame. This schema describes the message with `data` already parsed.
 */
@Serializable
public data class BusEventMessage(
    @SerialName("event")
    @EncodeDefault
    public val event: BusEventMessageEvent = BusEventMessageEvent.BusEvent,
    @SerialName("id")
    public val id: String,
    @SerialName("data")
    public val data: BusFrame,
) : BusStreamMessage {
    /** How Java makes a `BusEventMessage`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val data: BusFrame,
    ) {
        public fun build(): BusEventMessage = BusEventMessage(id = id, data = data)
    }

    public companion object {
        /** A builder of a `BusEventMessage` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, data: BusFrame): Builder = Builder(id, data)
    }
}
