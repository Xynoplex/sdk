// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** An annotation's graph presence. The node IS the annotation, so the full W3C object is required — selectors and body included, which is what lets a client place context annotations without a second fetch. Citations ride here too: an inbound reference is its linking annotation, anchored by an `annotation-of` edge to the resource it lives on and a `cites` edge to the focal resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GraphAnnotationNode(
    /** The AnnotationId — the same value as annotation.id */
    @get:JvmExposeBoxed
    public val id: AnnotationId,
    @EncodeDefault
    public val type: GraphAnnotationNodeType = GraphAnnotationNodeType.Annotation,
    /** The annotation's motivation, as a display label */
    public val label: String,
    /** Entity types carried by the annotation */
    public val entityTypes: kotlin.collections.List<String>? = null,
    public val annotation: Annotation,
    public val metadata: kotlin.collections.Map<String, JsonElement>? = null,
) : KnowledgeGraphNodesItem {
    /** How Java makes a `GraphAnnotationNode`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: AnnotationId,
        private val label: String,
        private val annotation: Annotation,
    ) {
        private var entityTypes: kotlin.collections.List<String>? = null
        private var metadata: kotlin.collections.Map<String, JsonElement>? = null

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun metadata(metadata: kotlin.collections.Map<String, JsonElement>?): Builder = apply { this.metadata = metadata }

        public fun build(): GraphAnnotationNode = GraphAnnotationNode(id = id, label = label, entityTypes = entityTypes, annotation = annotation, metadata = metadata)
    }

    public companion object {
        /** A builder of a `GraphAnnotationNode` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: AnnotationId, label: String, annotation: Annotation): Builder = Builder(id, label, annotation)
    }
}
