// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** A resource's presence in the gathered knowledge graph. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GraphResourceNode(
    /** The resource's ResourceId */
    @get:JvmExposeBoxed
    public val id: ResourceId,
    @EncodeDefault
    public val type: GraphResourceNodeType = GraphResourceNodeType.Resource,
    /** The resource's display name — its raw id when the resource's view was missing at build time */
    public val label: String,
    /** Entity types on the resource */
    public val entityTypes: kotlin.collections.List<String>? = null,
    public val metadata: kotlin.collections.Map<String, JsonElement>? = null,
) : KnowledgeGraphNodesItem {
    /** How Java makes a `GraphResourceNode`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: ResourceId,
        private val label: String,
    ) {
        private var entityTypes: kotlin.collections.List<String>? = null
        private var metadata: kotlin.collections.Map<String, JsonElement>? = null

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun metadata(metadata: kotlin.collections.Map<String, JsonElement>?): Builder = apply { this.metadata = metadata }

        public fun build(): GraphResourceNode = GraphResourceNode(id = id, label = label, entityTypes = entityTypes, metadata = metadata)
    }

    public companion object {
        /** A builder of a `GraphResourceNode` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: ResourceId, label: String): Builder = Builder(id, label)
    }
}
