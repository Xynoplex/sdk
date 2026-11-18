// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** What a highlighting job takes: passages of the resource worth a reader's attention are marked, with no text of the job's own. */
@Serializable
public data class HighlightingJobParams(
    @EncodeDefault
    public val motivation: HighlightingJobParamsMotivation = HighlightingJobParamsMotivation.Highlighting,
    /** What to look for, in the caller's words. Added to the prompt. */
    public val instructions: String? = null,
    /** How many annotations to aim for per 2000 words of the resource. */
    public val density: Double? = null,
    /** The language of the resource being read. BCP 47. */
    public val sourceLanguage: String? = null,
) : MarkJobParams {
    /** How Java makes a `HighlightingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var instructions: String? = null
        private var density: Double? = null
        private var sourceLanguage: String? = null

        public fun instructions(instructions: String?): Builder = apply { this.instructions = instructions }
        public fun density(density: Double?): Builder = apply { this.density = density }
        public fun sourceLanguage(sourceLanguage: String?): Builder = apply { this.sourceLanguage = sourceLanguage }

        public fun build(): HighlightingJobParams = HighlightingJobParams(instructions = instructions, density = density, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `HighlightingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
