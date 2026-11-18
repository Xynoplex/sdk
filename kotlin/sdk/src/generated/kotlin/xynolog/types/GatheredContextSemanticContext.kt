// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Semantically similar passages from across the knowledge base, found via vector search */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextSemanticContext(
    /** Passages ranked by cosine similarity to the focal text */
    public val similar: kotlin.collections.List<SemanticMatch>,
    /** Entity types excluded from this recall — a record of how `similar` was filtered (e.g. ['Question'] so answer-generation never surfaces prior questions). Absent when no exclusion was applied. */
    public val excludedEntityTypes: kotlin.collections.List<String>? = null,
) {
    /** How Java makes a `GatheredContextSemanticContext`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val similar: kotlin.collections.List<SemanticMatch>,
    ) {
        private var excludedEntityTypes: kotlin.collections.List<String>? = null

        public fun excludedEntityTypes(excludedEntityTypes: kotlin.collections.List<String>?): Builder = apply { this.excludedEntityTypes = excludedEntityTypes }

        public fun build(): GatheredContextSemanticContext = GatheredContextSemanticContext(similar = similar, excludedEntityTypes = excludedEntityTypes)
    }

    public companion object {
        /** A builder of a `GatheredContextSemanticContext` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(similar: kotlin.collections.List<SemanticMatch>): Builder = Builder(similar)
    }
}
