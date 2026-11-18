// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/** Every message the bus stream carries. A client ignores an `event` it does not know; the gateway writes no other. */
@Serializable(with = BusStreamMessageSerializer::class)
public sealed interface BusStreamMessage

internal object BusStreamMessageSerializer : JsonContentPolymorphicSerializer<BusStreamMessage>(BusStreamMessage::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.BusStreamMessage", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<BusStreamMessage> =
        firstThatFits<BusStreamMessage>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(BusEventMessage.serializer(), BusPingMessage.serializer())
            },
            "BusStreamMessage",
        )
}
