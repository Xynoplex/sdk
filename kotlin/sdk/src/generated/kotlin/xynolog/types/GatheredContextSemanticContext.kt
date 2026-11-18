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
 * Semantically similar passages from across the knowledge base, found via vector search
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextSemanticContext(
    /**
     * Passages ranked by cosine similarity to the focal text
     */
    @SerialName("similar")
    public val similar: kotlin.collections.List<SemanticMatch>,
    /**
     * Entity types excluded from this recall — a record of how `similar` was filtered (e.g. ['Question'] so answer-generation never surfaces prior questions). Absent when no exclusion was applied.
     */
    @SerialName("excludedEntityTypes")
    public val excludedEntityTypes: kotlin.collections.List<String>? = null,
) {
    /** How Java makes a `GatheredContextSemanticContext`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val similar: kotlin.collections.List<SemanticMatch>,
    ) {
        private var excludedEntityTypes: kotlin.collections.List<String>? = null

        public fun excludedEntityTypes(excludedEntityTypes: kotlin.collections.List<String>?): Builder {
            this.excludedEntityTypes = excludedEntityTypes
            return this
        }

        public fun build(): GatheredContextSemanticContext = GatheredContextSemanticContext(similar = similar, excludedEntityTypes = excludedEntityTypes)
    }

    public companion object {
        /** A builder of a `GatheredContextSemanticContext` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(similar: kotlin.collections.List<SemanticMatch>): Builder = Builder(similar)
    }
}
