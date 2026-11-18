// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** What a commenting job takes: passages of the resource are marked, each with a comment the model writes. */
@Serializable
public data class CommentingJobParams(
    @EncodeDefault
    public val motivation: CommentingJobParamsMotivation = CommentingJobParamsMotivation.Commenting,
    /** What to look for, in the caller's words. Added to the prompt. */
    public val instructions: String? = null,
    /** The voice the comments are written in. */
    public val tone: CommentingJobParamsTone? = null,
    /** How many annotations to aim for per 2000 words of the resource. */
    public val density: Double? = null,
    /** The language the annotations' own text is written in. BCP 47. */
    public val language: String? = null,
    /** The language of the resource being read. BCP 47. */
    public val sourceLanguage: String? = null,
) : MarkJobParams {
    /** How Java makes a `CommentingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var instructions: String? = null
        private var tone: CommentingJobParamsTone? = null
        private var density: Double? = null
        private var language: String? = null
        private var sourceLanguage: String? = null

        public fun instructions(instructions: String?): Builder = apply { this.instructions = instructions }
        public fun tone(tone: CommentingJobParamsTone?): Builder = apply { this.tone = tone }
        public fun density(density: Double?): Builder = apply { this.density = density }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun sourceLanguage(sourceLanguage: String?): Builder = apply { this.sourceLanguage = sourceLanguage }

        public fun build(): CommentingJobParams = CommentingJobParams(instructions = instructions, tone = tone, density = density, language = language, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `CommentingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
