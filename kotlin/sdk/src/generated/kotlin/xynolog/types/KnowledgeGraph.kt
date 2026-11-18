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
 * Knowledge graph gathered for an LLM context — a shared backbone in which resources AND annotations are typed nodes, connected by typed (optionally bidirectional) edges. Flattened views the matcher/generation read (connections, citedBy, siblings) are derived from these nodes/edges.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class KnowledgeGraph(
    @SerialName("nodes")
    public val nodes: kotlin.collections.List<KnowledgeGraphNodesItem>,
    @SerialName("edges")
    public val edges: kotlin.collections.List<KnowledgeGraphEdgesItem>,
    /**
     * Whether the graph stopped taking resources at its ceiling of 200 resource nodes, so that a resource within the depth asked for is not in it. Present, and true, only then
     */
    @SerialName("truncated")
    public val truncated: Boolean? = null,
) {
    /** How Java makes a `KnowledgeGraph`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val nodes: kotlin.collections.List<KnowledgeGraphNodesItem>,
        private val edges: kotlin.collections.List<KnowledgeGraphEdgesItem>,
    ) {
        private var truncated: Boolean? = null

        public fun truncated(truncated: Boolean?): Builder {
            this.truncated = truncated
            return this
        }

        public fun build(): KnowledgeGraph = KnowledgeGraph(nodes = nodes, edges = edges, truncated = truncated)
    }

    public companion object {
        /** A builder of a `KnowledgeGraph` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(nodes: kotlin.collections.List<KnowledgeGraphNodesItem>, edges: kotlin.collections.List<KnowledgeGraphEdgesItem>): Builder = Builder(nodes, edges)
    }
}
