// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** What an assessing job takes: passages of the resource are marked, each with an assessment the model writes. */
@Serializable
public data class AssessingJobParams(
    @EncodeDefault
    public val motivation: AssessingJobParamsMotivation = AssessingJobParamsMotivation.Assessing,
    /** What to look for, in the caller's words. Added to the prompt. */
    public val instructions: String? = null,
    /** The stance the assessments are written from. */
    public val tone: AssessingJobParamsTone? = null,
    /** How many annotations to aim for per 2000 words of the resource. */
    public val density: Double? = null,
    /** The language the annotations' own text is written in. BCP 47. */
    public val language: String? = null,
    /** The language of the resource being read. BCP 47. */
    public val sourceLanguage: String? = null,
) : MarkJobParams {
    /** How Java makes a `AssessingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var instructions: String? = null
        private var tone: AssessingJobParamsTone? = null
        private var density: Double? = null
        private var language: String? = null
        private var sourceLanguage: String? = null

        public fun instructions(instructions: String?): Builder = apply { this.instructions = instructions }
        public fun tone(tone: AssessingJobParamsTone?): Builder = apply { this.tone = tone }
        public fun density(density: Double?): Builder = apply { this.density = density }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun sourceLanguage(sourceLanguage: String?): Builder = apply { this.sourceLanguage = sourceLanguage }

        public fun build(): AssessingJobParams = AssessingJobParams(instructions = instructions, tone = tone, density = density, language = language, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `AssessingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
