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

/** Persistent identifiers (e.g., DOI, URN). */
@Serializable(with = ScoredResourceIdentifierSerializer::class)
public sealed interface ScoredResourceIdentifier {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ScoredResourceIdentifier {
        internal object Serializer : KSerializer<Text> {
            private val value: KSerializer<String> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("xynolog.types.ScoredResourceIdentifier.Text", PrimitiveKind.STRING)

            override fun serialize(encoder: Encoder, value: Text) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): Text = Text(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `List<String>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<String>) : ScoredResourceIdentifier {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<String>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceIdentifier.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ScoredResourceIdentifierSerializer : JsonContentPolymorphicSerializer<ScoredResourceIdentifier>(ScoredResourceIdentifier::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ScoredResourceIdentifier", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ScoredResourceIdentifier> =
        firstThatFits<ScoredResourceIdentifier>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(ScoredResourceIdentifier.Text.serializer()) else emptyList()
                is JsonArray -> listOf(ScoredResourceIdentifier.List.serializer())
                is JsonObject -> listOf(ScoredResourceIdentifierObject.serializer())
            },
            "ScoredResourceIdentifier",
        )
}
