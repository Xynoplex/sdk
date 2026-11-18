// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Context metadata about the focal anchor and its source */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextMetadata(
    /** Type of source resource (e.g., 'document', 'image', 'video') */
    public val resourceType: String? = null,
    /** BCP 47 language tag of source content */
    public val language: String? = null,
    /** Entity types associated with the focal anchor */
    public val entityTypes: kotlin.collections.List<String>? = null,
    /** Global frequency counts for entity types (for IDF-like weighting). A KB-wide statistic, not a neighborhood property — kept here rather than on the graph. */
    public val entityTypeFrequencies: kotlin.collections.Map<String, Long>? = null,
) {
    /** How Java makes a `GatheredContextMetadata`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var resourceType: String? = null
        private var language: String? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var entityTypeFrequencies: kotlin.collections.Map<String, Long>? = null

        public fun resourceType(resourceType: String?): Builder = apply { this.resourceType = resourceType }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun entityTypeFrequencies(entityTypeFrequencies: kotlin.collections.Map<String, Long>?): Builder = apply { this.entityTypeFrequencies = entityTypeFrequencies }

        public fun build(): GatheredContextMetadata = GatheredContextMetadata(resourceType = resourceType, language = language, entityTypes = entityTypes, entityTypeFrequencies = entityTypeFrequencies)
    }

    public companion object {
        /** A builder of a `GatheredContextMetadata` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
