// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** What a tagging job takes: passages of the resource are marked with categories of one tag schema. */
@Serializable
public data class TaggingJobParams(
    @EncodeDefault
    public val motivation: TaggingJobParamsMotivation = TaggingJobParamsMotivation.Tagging,
    /** The tag schema to tag by. It is one the knowledge base registers. */
    public val schemaId: String,
    /** The categories of that schema to tag with. */
    public val categories: kotlin.collections.List<String>,
    /** The language the annotations' own text is written in. BCP 47. */
    public val language: String? = null,
    /** The language of the resource being read. BCP 47. */
    public val sourceLanguage: String? = null,
) : MarkJobParams {
    /** How Java makes a `TaggingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val schemaId: String,
        private val categories: kotlin.collections.List<String>,
    ) {
        private var language: String? = null
        private var sourceLanguage: String? = null

        public fun language(language: String?): Builder = apply { this.language = language }
        public fun sourceLanguage(sourceLanguage: String?): Builder = apply { this.sourceLanguage = sourceLanguage }

        public fun build(): TaggingJobParams = TaggingJobParams(schemaId = schemaId, categories = categories, language = language, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `TaggingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(schemaId: String, categories: kotlin.collections.List<String>): Builder = Builder(schemaId, categories)
    }
}
