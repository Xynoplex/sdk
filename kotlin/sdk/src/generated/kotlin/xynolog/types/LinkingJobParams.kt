// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** What a linking job takes: mentions of the named entity types are marked as references, each unresolved until it is bound to a resource. */
@Serializable
public data class LinkingJobParams(
    @EncodeDefault
    public val motivation: LinkingJobParamsMotivation = LinkingJobParamsMotivation.Linking,
    /** The entity types to find mentions of. Each is one the knowledge base registers. */
    public val entityTypes: kotlin.collections.List<String>,
    /** Whether a description that stands for an entity ("the wily hero") counts as a mention of it, beside its name. */
    public val includeDescriptiveReferences: Boolean? = null,
    /** The language the annotations' own text is written in. BCP 47. */
    public val language: String? = null,
    /** The language of the resource being read. BCP 47. */
    public val sourceLanguage: String? = null,
) : MarkJobParams {
    /** How Java makes a `LinkingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        private var includeDescriptiveReferences: Boolean? = null
        private var language: String? = null
        private var sourceLanguage: String? = null

        public fun includeDescriptiveReferences(includeDescriptiveReferences: Boolean?): Builder = apply { this.includeDescriptiveReferences = includeDescriptiveReferences }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun sourceLanguage(sourceLanguage: String?): Builder = apply { this.sourceLanguage = sourceLanguage }

        public fun build(): LinkingJobParams = LinkingJobParams(entityTypes = entityTypes, includeDescriptiveReferences = includeDescriptiveReferences, language = language, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `LinkingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityTypes: kotlin.collections.List<String>): Builder = Builder(entityTypes)
    }
}
