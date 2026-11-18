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

@Serializable
@JsonIgnoreUnknownKeys
public data class KnowledgeGraphEdgesItem(
    @SerialName("source")
    public val source: String,
    @SerialName("target")
    public val target: String,
    /**
     * Edge kind: `annotation-of` (an annotation → the resource it lives on), `cites` (a citing linking annotation → the focal resource), or `link` (a resource → a resource it links to)
     */
    @SerialName("type")
    public val type: String,
    /**
     * Whether the connection goes both ways. Absent on a `link` edge found through what cites a resource, which says nothing of the way back
     */
    @SerialName("bidirectional")
    public val bidirectional: Boolean? = null,
    @SerialName("metadata")
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

        public fun bidirectional(bidirectional: Boolean?): Builder {
            this.bidirectional = bidirectional
            return this
        }

        public fun metadata(metadata: kotlin.collections.Map<String, JsonElement>?): Builder {
            this.metadata = metadata
            return this
        }

        public fun build(): KnowledgeGraphEdgesItem = KnowledgeGraphEdgesItem(source = source, target = target, type = type, bidirectional = bidirectional, metadata = metadata)
    }

    public companion object {
        /** A builder of a `KnowledgeGraphEdgesItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(source: String, target: String, type: String): Builder = Builder(source, target, type)
    }
}
