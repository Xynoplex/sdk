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

@Serializable(with = ResourceDescriptorContextItemSerializer::class)
public sealed interface ResourceDescriptorContextItem {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ResourceDescriptorContextItem {
        internal object Serializer : KSerializer<Text> {
            private val value: KSerializer<String> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.types.ResourceDescriptorContextItem.Text", PrimitiveKind.STRING)

            override fun serialize(encoder: Encoder, value: Text) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Text = Text(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `JsonObject`, as the value itself. */
    @Serializable(with = Object.Serializer::class)
    public data class Object(public val value: JsonObject) : ResourceDescriptorContextItem {
        internal object Serializer : KSerializer<Object> {
            private val value: KSerializer<JsonObject> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorContextItem.Object", value.descriptor)

            override fun serialize(encoder: Encoder, value: Object) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Object = Object(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ResourceDescriptorContextItemSerializer : JsonContentPolymorphicSerializer<ResourceDescriptorContextItem>(ResourceDescriptorContextItem::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorContextItem", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ResourceDescriptorContextItem> =
        firstThatFits<ResourceDescriptorContextItem>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(ResourceDescriptorContextItem.Text.serializer()) else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(ResourceDescriptorContextItem.Object.serializer())
            },
            "ResourceDescriptorContextItem",
        )
}
