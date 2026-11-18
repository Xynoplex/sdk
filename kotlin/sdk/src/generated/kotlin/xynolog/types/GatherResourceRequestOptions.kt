// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Gathering configuration */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherResourceRequestOptions(
    /** How many links out from the resource the knowledge graph reaches, nearest first: 1 is what the resource links to and what cites it, and each further link out adds what those link to and what cites them */
    public val depth: Long,
    /** Maximum number of related resources to include */
    public val maxResources: Long,
    /** Whether to include resource content in the gathered result */
    public val includeContent: Boolean,
    /** Whether to include resource summaries in the gathered result */
    public val includeSummary: Boolean,
    /** Entity types to exclude from the semantic recall built into this context (caller-supplied; e.g. a chat consumer passes ['Question'] so prior questions never ground answer generation). Optional; default none. */
    public val excludeEntityTypes: kotlin.collections.List<String>? = null,
) {
    /** How Java makes a `GatherResourceRequestOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val depth: Long,
        private val maxResources: Long,
        private val includeContent: Boolean,
        private val includeSummary: Boolean,
    ) {
        private var excludeEntityTypes: kotlin.collections.List<String>? = null

        public fun excludeEntityTypes(excludeEntityTypes: kotlin.collections.List<String>?): Builder = apply { this.excludeEntityTypes = excludeEntityTypes }

        public fun build(): GatherResourceRequestOptions = GatherResourceRequestOptions(depth = depth, maxResources = maxResources, includeContent = includeContent, includeSummary = includeSummary, excludeEntityTypes = excludeEntityTypes)
    }

    public companion object {
        /** A builder of a `GatherResourceRequestOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(depth: Long, maxResources: Long, includeContent: Boolean, includeSummary: Boolean): Builder = Builder(depth, maxResources, includeContent, includeSummary)
    }
}
