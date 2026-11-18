// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class KnowledgeGraphEdgesItem(
    public val source: String,
    public val target: String,
    /** Edge kind: `annotation-of` (an annotation → the resource it lives on), `cites` (a citing linking annotation → the focal resource), or `link` (a resource → a resource it links to) */
    public val type: String,
    /** Whether the connection goes both ways. Absent on a `link` edge found through what cites a resource, which says nothing of the way back */
    public val bidirectional: Boolean? = null,
    public val metadata: kotlin.collections.Map<String, JsonElement>? = null,
) {
    /** How Java makes a `KnowledgeGraphEdgesItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: String,
        private val target: String,
        private val type: String,
    ) {
        private var bidirectional: Boolean? = null
        private var metadata: kotlin.collections.Map<String, JsonElement>? = null

        public fun bidirectional(bidirectional: Boolean?): Builder = apply { this.bidirectional = bidirectional }
        public fun metadata(metadata: kotlin.collections.Map<String, JsonElement>?): Builder = apply { this.metadata = metadata }

        public fun build(): KnowledgeGraphEdgesItem = KnowledgeGraphEdgesItem(source = source, target = target, type = type, bidirectional = bidirectional, metadata = metadata)
    }

    public companion object {
        /** A builder of a `KnowledgeGraphEdgesItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(source: String, target: String, type: String): Builder = Builder(source, target, type)
    }
}
