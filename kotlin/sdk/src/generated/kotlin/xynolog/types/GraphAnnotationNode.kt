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
 * An annotation's graph presence. The node IS the annotation, so the full W3C object is required — selectors and body included, which is what lets a client place context annotations without a second fetch. Citations ride here too: an inbound reference is its linking annotation, anchored by an `annotation-of` edge to the resource it lives on and a `cites` edge to the focal resource.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GraphAnnotationNode(
    /**
     * The AnnotationId — the same value as annotation.id
     */
    @SerialName("id")
    @get:JvmExposeBoxed
    public val id: AnnotationId,
    @SerialName("type")
    @EncodeDefault
    public val type: GraphAnnotationNodeType = GraphAnnotationNodeType.Annotation,
    /**
     * The annotation's motivation, as a display label
     */
    @SerialName("label")
    public val label: String,
    /**
     * Entity types carried by the annotation
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    @SerialName("annotation")
    public val annotation: Annotation,
    @SerialName("metadata")
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

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun metadata(metadata: kotlin.collections.Map<String, JsonElement>?): Builder {
            this.metadata = metadata
            return this
        }

        public fun build(): GraphAnnotationNode = GraphAnnotationNode(id = id, label = label, entityTypes = entityTypes, annotation = annotation, metadata = metadata)
    }

    public companion object {
        /** A builder of a `GraphAnnotationNode` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: AnnotationId, label: String, annotation: Annotation): Builder = Builder(id, label, annotation)
    }
}
