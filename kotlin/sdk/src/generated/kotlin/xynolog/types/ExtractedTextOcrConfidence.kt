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
 * How well the engine read the pixels, when any of this text came from OCR.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class ExtractedTextOcrConfidence(
    /**
     * Mean per-word confidence, 0-100.
     */
    @SerialName("mean")
    public val mean: Double,
    /**
     * Words the engine was unsure of.
     */
    @SerialName("lowConfidenceWords")
    public val lowConfidenceWords: Long,
    @SerialName("totalWords")
    public val totalWords: Long,
) {
    /** How Java makes a `ExtractedTextOcrConfidence`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val mean: Double,
        private val lowConfidenceWords: Long,
        private val totalWords: Long,
    ) {
        public fun build(): ExtractedTextOcrConfidence = ExtractedTextOcrConfidence(mean = mean, lowConfidenceWords = lowConfidenceWords, totalWords = totalWords)
    }

    public companion object {
        /** A builder of a `ExtractedTextOcrConfidence` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(mean: Double, lowConfidenceWords: Long, totalWords: Long): Builder = Builder(mean, lowConfidenceWords, totalWords)
    }
}
