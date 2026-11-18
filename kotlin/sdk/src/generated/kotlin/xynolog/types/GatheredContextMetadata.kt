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
 * Context metadata about the focal anchor and its source
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextMetadata(
    /**
     * Type of source resource (e.g., 'document', 'image', 'video')
     */
    @SerialName("resourceType")
    public val resourceType: String? = null,
    /**
     * BCP 47 language tag of source content
     */
    @SerialName("language")
    public val language: String? = null,
    /**
     * Entity types associated with the focal anchor
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    /**
     * Global frequency counts for entity types (for IDF-like weighting). A KB-wide statistic, not a neighborhood property — kept here rather than on the graph.
     */
    @SerialName("entityTypeFrequencies")
    public val entityTypeFrequencies: kotlin.collections.Map<String, Long>? = null,
) {
    /** How Java makes a `GatheredContextMetadata`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var resourceType: String? = null
        private var language: String? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var entityTypeFrequencies: kotlin.collections.Map<String, Long>? = null

        public fun resourceType(resourceType: String?): Builder {
            this.resourceType = resourceType
            return this
        }

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun entityTypeFrequencies(entityTypeFrequencies: kotlin.collections.Map<String, Long>?): Builder {
            this.entityTypeFrequencies = entityTypeFrequencies
            return this
        }

        public fun build(): GatheredContextMetadata = GatheredContextMetadata(resourceType = resourceType, language = language, entityTypes = entityTypes, entityTypeFrequencies = entityTypeFrequencies)
    }

    public companion object {
        /** A builder of a `GatheredContextMetadata` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
