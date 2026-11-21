// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What gathering the context of a resource is told beside the resource: GatherResourceRequestOptions, each member of which a caller may leave out. client/surface.json's `gather.resource` cases state what is sent for one left out. */
@Serializable
public data class GatherResourceOptions(
    /** How many links out from the resource the knowledge graph reaches, nearest first: 1 is what the resource links to and what cites it, and each further link out adds what those link to and what cites them */
    public val depth: Long? = null,
    /** Maximum number of related resources to include */
    public val maxResources: Long? = null,
    /** Whether to include resource content in the gathered result */
    public val includeContent: Boolean? = null,
    /** Whether to include resource summaries in the gathered result */
    public val includeSummary: Boolean? = null,
    /** Entity types to exclude from the semantic recall built into this context (caller-supplied; e.g. a chat consumer passes ['Question'] so prior questions never ground answer generation). Optional; default none. */
    public val excludeEntityTypes: kotlin.collections.List<String>? = null,
) {
    /** How Java makes a `GatherResourceOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var depth: Long? = null
        private var maxResources: Long? = null
        private var includeContent: Boolean? = null
        private var includeSummary: Boolean? = null
        private var excludeEntityTypes: kotlin.collections.List<String>? = null

        public fun depth(depth: Long?): Builder = apply { this.depth = depth }
        public fun maxResources(maxResources: Long?): Builder = apply { this.maxResources = maxResources }
        public fun includeContent(includeContent: Boolean?): Builder = apply { this.includeContent = includeContent }
        public fun includeSummary(includeSummary: Boolean?): Builder = apply { this.includeSummary = includeSummary }
        public fun excludeEntityTypes(excludeEntityTypes: kotlin.collections.List<String>?): Builder = apply { this.excludeEntityTypes = excludeEntityTypes }

        public fun build(): GatherResourceOptions = GatherResourceOptions(depth = depth, maxResources = maxResources, includeContent = includeContent, includeSummary = includeSummary, excludeEntityTypes = excludeEntityTypes)
    }

    public companion object {
        /** A builder of a `GatherResourceOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
