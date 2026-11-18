// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Knowledge graph gathered for an LLM context — a shared backbone in which resources AND annotations are typed nodes, connected by typed (optionally bidirectional) edges. Flattened views the matcher/generation read (connections, citedBy, siblings) are derived from these nodes/edges. */
@Serializable
@JsonIgnoreUnknownKeys
public data class KnowledgeGraph(
    public val nodes: kotlin.collections.List<KnowledgeGraphNodesItem>,
    public val edges: kotlin.collections.List<KnowledgeGraphEdgesItem>,
    /** Whether the graph stopped taking resources at its ceiling of 200 resource nodes, so that a resource within the depth asked for is not in it. Present, and true, only then */
    public val truncated: Boolean? = null,
) {
    /** How Java makes a `KnowledgeGraph`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val nodes: kotlin.collections.List<KnowledgeGraphNodesItem>,
        private val edges: kotlin.collections.List<KnowledgeGraphEdgesItem>,
    ) {
        private var truncated: Boolean? = null

        public fun truncated(truncated: Boolean?): Builder = apply { this.truncated = truncated }

        public fun build(): KnowledgeGraph = KnowledgeGraph(nodes = nodes, edges = edges, truncated = truncated)
    }

    public companion object {
        /** A builder of a `KnowledgeGraph` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(nodes: kotlin.collections.List<KnowledgeGraphNodesItem>, edges: kotlin.collections.List<KnowledgeGraphEdgesItem>): Builder = Builder(nodes, edges)
    }
}
