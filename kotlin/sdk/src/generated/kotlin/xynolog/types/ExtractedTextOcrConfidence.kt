// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** How well the engine read the pixels, when any of this text came from OCR. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ExtractedTextOcrConfidence(
    /** Mean per-word confidence, 0-100. */
    public val mean: Double,
    /** Words the engine was unsure of. */
    public val lowConfidenceWords: Long,
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
