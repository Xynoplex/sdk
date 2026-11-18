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
 * What a reader gets when it asks for a resource's coordinate map: the map, a stored decline, or a named absence.
 *
 * Distinct from `ExtractionOutcome` on purpose. That type is what the STORE holds and what an extractor RETURNS — neither of which can ever be 'not yet'. This is the read answer, which can, so widening ExtractionOutcome itself would have put an impossible state into the store's own type.
 *
 * Flat, one discriminant: every member carries `kind`, rather than nesting an outcome inside a status envelope and giving the wire two `kind` fields at different depths.
 */
@Serializable(with = AnchoredTextAnswerSerializer::class)
public sealed interface AnchoredTextAnswer

internal object AnchoredTextAnswerSerializer : JsonContentPolymorphicSerializer<AnchoredTextAnswer>(AnchoredTextAnswer::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnchoredTextAnswer", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AnchoredTextAnswer> =
        firstThatFits<AnchoredTextAnswer>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(ExtractedText.serializer(), ExtractionDeclined.serializer(), AnchoredTextAbsent.serializer())
            },
            "AnchoredTextAnswer",
        )
}
