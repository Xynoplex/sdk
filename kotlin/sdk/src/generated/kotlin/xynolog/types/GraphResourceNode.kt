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
 * A resource's presence in the gathered knowledge graph.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GraphResourceNode(
    /**
     * The resource's ResourceId
     */
    @SerialName("id")
    @get:JvmExposeBoxed
    public val id: ResourceId,
    @SerialName("type")
    @EncodeDefault
    public val type: GraphResourceNodeType = GraphResourceNodeType.Resource,
    /**
     * The resource's display name — its raw id when the resource's view was missing at build time
     */
    @SerialName("label")
    public val label: String,
    /**
     * Entity types on the resource
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    @SerialName("metadata")
    public val metadata: kotlin.collections.Map<String, JsonElement>? = null,
) : KnowledgeGraphNodesItem {
    /** How Java makes a `GraphResourceNode`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: ResourceId,
        private val label: String,
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

        public fun build(): GraphResourceNode = GraphResourceNode(id = id, label = label, entityTypes = entityTypes, metadata = metadata)
    }

    public companion object {
        /** A builder of a `GraphResourceNode` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: ResourceId, label: String): Builder = Builder(id, label)
    }
}
