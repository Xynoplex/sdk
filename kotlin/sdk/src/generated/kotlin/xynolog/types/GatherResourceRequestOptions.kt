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
 * Gathering configuration
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherResourceRequestOptions(
    /**
     * How many links out from the resource the knowledge graph reaches, nearest first: 1 is what the resource links to and what cites it, and each further link out adds what those link to and what cites them
     */
    @SerialName("depth")
    public val depth: Long,
    /**
     * Maximum number of related resources to include
     */
    @SerialName("maxResources")
    public val maxResources: Long,
    /**
     * Whether to include resource content in the gathered result
     */
    @SerialName("includeContent")
    public val includeContent: Boolean,
    /**
     * Whether to include resource summaries in the gathered result
     */
    @SerialName("includeSummary")
    public val includeSummary: Boolean,
    /**
     * Entity types to exclude from the semantic recall built into this context (caller-supplied; e.g. a chat consumer passes ['Question'] so prior questions never ground answer generation). Optional; default none.
     */
    @SerialName("excludeEntityTypes")
    public val excludeEntityTypes: kotlin.collections.List<String>? = null,
) {
    /** How Java makes a `GatherResourceRequestOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val depth: Long,
        private val maxResources: Long,
        private val includeContent: Boolean,
        private val includeSummary: Boolean,
    ) {
        private var excludeEntityTypes: kotlin.collections.List<String>? = null

        public fun excludeEntityTypes(excludeEntityTypes: kotlin.collections.List<String>?): Builder {
            this.excludeEntityTypes = excludeEntityTypes
            return this
        }

        public fun build(): GatherResourceRequestOptions = GatherResourceRequestOptions(depth = depth, maxResources = maxResources, includeContent = includeContent, includeSummary = includeSummary, excludeEntityTypes = excludeEntityTypes)
    }

    public companion object {
        /** A builder of a `GatherResourceRequestOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(depth: Long, maxResources: Long, includeContent: Boolean, includeSummary: Boolean): Builder = Builder(depth, maxResources, includeContent, includeSummary)
    }
}
