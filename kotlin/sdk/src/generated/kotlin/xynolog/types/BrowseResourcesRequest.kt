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
 * Request to browse resources with optional filtering and pagination
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseResourcesRequest(
    @SerialName("archived")
    public val archived: Boolean? = null,
    @SerialName("entityType")
    public val entityType: String? = null,
    /**
     * How many of the resources the filters admit are passed over before the page begins.
     */
    @SerialName("offset")
    public val offset: Long? = null,
    /**
     * The most resources a page has.
     */
    @SerialName("limit")
    public val limit: Long? = null,
) {
    /** How Java makes a `BrowseResourcesRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var archived: Boolean? = null
        private var entityType: String? = null
        private var offset: Long? = null
        private var limit: Long? = null

        public fun archived(archived: Boolean?): Builder {
            this.archived = archived
            return this
        }

        public fun entityType(entityType: String?): Builder {
            this.entityType = entityType
            return this
        }

        public fun offset(offset: Long?): Builder {
            this.offset = offset
            return this
        }

        public fun limit(limit: Long?): Builder {
            this.limit = limit
            return this
        }

        public fun build(): BrowseResourcesRequest = BrowseResourcesRequest(archived = archived, entityType = entityType, offset = offset, limit = limit)
    }

    public companion object {
        /** A builder of a `BrowseResourcesRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
