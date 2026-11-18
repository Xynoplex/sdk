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

/** JSON-LD context; URI, object, or array of these. */
@Serializable(with = ResourceDescriptorContextSerializer::class)
public sealed interface ResourceDescriptorContext {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ResourceDescriptorContext {
        internal object Serializer : KSerializer<Text> {
            private val value: KSerializer<String> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.types.ResourceDescriptorContext.Text", PrimitiveKind.STRING)

            override fun serialize(encoder: Encoder, value: Text) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Text = Text(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `JsonObject`, as the value itself. */
    @Serializable(with = Object.Serializer::class)
    public data class Object(public val value: JsonObject) : ResourceDescriptorContext {
        internal object Serializer : KSerializer<Object> {
            private val value: KSerializer<JsonObject> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorContext.Object", value.descriptor)

            override fun serialize(encoder: Encoder, value: Object) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Object = Object(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `List<ResourceDescriptorContextItem>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<ResourceDescriptorContextItem>) : ResourceDescriptorContext {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<ResourceDescriptorContextItem>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorContext.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ResourceDescriptorContextSerializer : JsonContentPolymorphicSerializer<ResourceDescriptorContext>(ResourceDescriptorContext::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorContext", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ResourceDescriptorContext> =
        firstThatFits<ResourceDescriptorContext>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(ResourceDescriptorContext.Text.serializer()) else emptyList()
                is JsonArray -> listOf(ResourceDescriptorContext.List.serializer())
                is JsonObject -> listOf(ResourceDescriptorContext.Object.serializer())
            },
            "ResourceDescriptorContext",
        )
}
