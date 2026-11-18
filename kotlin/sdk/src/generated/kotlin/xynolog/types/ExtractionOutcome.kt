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
 * The full outcome of text extraction for one representation — the record the anchored-text store holds and the wire serves. Discriminated on `kind`: 'extracted' — the anchored text with its provenance; 'declined' — a named decline. ocrConfidence is extraction quality for operators, deliberately not anchor confidence.
 */
@Serializable(with = ExtractionOutcomeSerializer::class)
public sealed interface ExtractionOutcome

internal object ExtractionOutcomeSerializer : JsonContentPolymorphicSerializer<ExtractionOutcome>(ExtractionOutcome::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ExtractionOutcome", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ExtractionOutcome> =
        firstThatFits<ExtractionOutcome>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(ExtractedText.serializer(), ExtractionDeclined.serializer())
            },
            "ExtractionOutcome",
        )
}
