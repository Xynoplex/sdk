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
 * JSON-LD context; URI, object, or array of these.
 */
@Serializable(with = ScoredResourceContextSerializer::class)
public sealed interface ScoredResourceContext {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ScoredResourceContext {
        internal object Serializer : KSerializer<Text> {
            private val value: KSerializer<String> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.types.ScoredResourceContext.Text", PrimitiveKind.STRING)

            override fun serialize(encoder: Encoder, value: Text) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Text = Text(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `JsonObject`, as the value itself. */
    @Serializable(with = Object.Serializer::class)
    public data class Object(public val value: JsonObject) : ScoredResourceContext {
        internal object Serializer : KSerializer<Object> {
            private val value: KSerializer<JsonObject> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceContext.Object", value.descriptor)

            override fun serialize(encoder: Encoder, value: Object) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Object = Object(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `List<ScoredResourceContextItem>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<ScoredResourceContextItem>) : ScoredResourceContext {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<ScoredResourceContextItem>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceContext.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ScoredResourceContextSerializer : JsonContentPolymorphicSerializer<ScoredResourceContext>(ScoredResourceContext::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceContext", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ScoredResourceContext> =
        firstThatFits<ScoredResourceContext>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(ScoredResourceContext.Text.serializer()) else emptyList()
                is JsonArray -> listOf(ScoredResourceContext.List.serializer())
                is JsonObject -> listOf(ScoredResourceContext.Object.serializer())
            },
            "ScoredResourceContext",
        )
}
