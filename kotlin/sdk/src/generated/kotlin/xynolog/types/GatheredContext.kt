// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * Context gathered for a gather.* call — consumed by yield.* (generation) and the matcher. A shared base (graph, semanticContext, metadata, inferredRelationshipSummary) plus a discriminated `focus` that names the anchor: an annotation or a whole resource.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContext(
    /**
     * The gather anchor. Discriminated on `kind`.
     */
    @SerialName("focus")
    public val focus: GatheredContextFocus,
    /**
     * Knowledge graph backbone — resources AND annotations as typed nodes. The flattened views (connections, citedBy, siblings) are derived from this.
     */
    @SerialName("graph")
    public val graph: KnowledgeGraph,
    /**
     * Semantically similar passages from across the knowledge base, found via vector search
     */
    @SerialName("semanticContext")
    public val semanticContext: GatheredContextSemanticContext? = null,
    /**
     * Context metadata about the focal anchor and its source
     */
    @SerialName("metadata")
    public val metadata: GatheredContextMetadata,
    /**
     * LLM-generated summary of the focal anchor's relationships in the knowledge graph
     */
    @SerialName("inferredRelationshipSummary")
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

        public fun semanticContext(semanticContext: GatheredContextSemanticContext?): Builder {
            this.semanticContext = semanticContext
            return this
        }

        public fun inferredRelationshipSummary(inferredRelationshipSummary: String?): Builder {
            this.inferredRelationshipSummary = inferredRelationshipSummary
            return this
        }

        public fun build(): GatheredContext = GatheredContext(focus = focus, graph = graph, semanticContext = semanticContext, metadata = metadata, inferredRelationshipSummary = inferredRelationshipSummary)
    }

    public companion object {
        /** A builder of a `GatheredContext` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(focus: GatheredContextFocus, graph: KnowledgeGraph, metadata: GatheredContextMetadata): Builder = Builder(focus, graph, metadata)
    }
}
