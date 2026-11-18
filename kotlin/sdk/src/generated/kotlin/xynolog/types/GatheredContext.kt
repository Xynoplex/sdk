// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Context gathered for a gather.* call — consumed by yield.* (generation) and the matcher. A shared base (graph, semanticContext, metadata, inferredRelationshipSummary) plus a discriminated `focus` that names the anchor: an annotation or a whole resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContext(
    /** The gather anchor. Discriminated on `kind`. */
    public val focus: GatheredContextFocus,
    /** Knowledge graph backbone — resources AND annotations as typed nodes. The flattened views (connections, citedBy, siblings) are derived from this. */
    public val graph: KnowledgeGraph,
    /** Semantically similar passages from across the knowledge base, found via vector search */
    public val semanticContext: GatheredContextSemanticContext? = null,
    /** Context metadata about the focal anchor and its source */
    public val metadata: GatheredContextMetadata,
    /** LLM-generated summary of the focal anchor's relationships in the knowledge graph */
    public val inferredRelationshipSummary: String? = null,
) {
    /** How Java makes a `GatheredContext`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val focus: GatheredContextFocus,
        private val graph: KnowledgeGraph,
        private val metadata: GatheredContextMetadata,
    ) {
        private var semanticContext: GatheredContextSemanticContext? = null
        private var inferredRelationshipSummary: String? = null

        public fun semanticContext(semanticContext: GatheredContextSemanticContext?): Builder = apply { this.semanticContext = semanticContext }
        public fun inferredRelationshipSummary(inferredRelationshipSummary: String?): Builder = apply { this.inferredRelationshipSummary = inferredRelationshipSummary }

        public fun build(): GatheredContext = GatheredContext(focus = focus, graph = graph, semanticContext = semanticContext, metadata = metadata, inferredRelationshipSummary = inferredRelationshipSummary)
    }

    public companion object {
        /** A builder of a `GatheredContext` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(focus: GatheredContextFocus, graph: KnowledgeGraph, metadata: GatheredContextMetadata): Builder = Builder(focus, graph, metadata)
    }
}
