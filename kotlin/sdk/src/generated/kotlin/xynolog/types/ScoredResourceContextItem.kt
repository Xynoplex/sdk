// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.KSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

@Serializable(with = ScoredResourceContextItemSerializer::class)
public sealed interface ScoredResourceContextItem {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ScoredResourceContextItem {
        internal object Serializer : KSerializer<Text> {
            private val value: KSerializer<String> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.types.ScoredResourceContextItem.Text", PrimitiveKind.STRING)

            override fun serialize(encoder: Encoder, value: Text) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Text = Text(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `JsonObject`, as the value itself. */
    @Serializable(with = Object.Serializer::class)
    public data class Object(public val value: JsonObject) : ScoredResourceContextItem {
        internal object Serializer : KSerializer<Object> {
            private val value: KSerializer<JsonObject> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceContextItem.Object", value.descriptor)

            override fun serialize(encoder: Encoder, value: Object) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Object = Object(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ScoredResourceContextItemSerializer : JsonContentPolymorphicSerializer<ScoredResourceContextItem>(ScoredResourceContextItem::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceContextItem", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ScoredResourceContextItem> =
        firstThatFits<ScoredResourceContextItem>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(ScoredResourceContextItem.Text.serializer()) else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(ScoredResourceContextItem.Object.serializer())
            },
            "ScoredResourceContextItem",
        )
}
