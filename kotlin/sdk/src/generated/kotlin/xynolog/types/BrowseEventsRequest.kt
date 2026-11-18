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
 * Request to browse events for a resource
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseEventsRequest(
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @SerialName("type")
    public val type: String? = null,
    @SerialName("userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @SerialName("limit")
    public val limit: Long? = null,
) {
    /** How Java makes a `BrowseEventsRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var type: String? = null
        private var userId: UserId? = null
        private var limit: Long? = null

        public fun type(type: String?): Builder {
            this.type = type
            return this
        }

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun limit(limit: Long?): Builder {
            this.limit = limit
            return this
        }

        public fun build(): BrowseEventsRequest = BrowseEventsRequest(resourceId = resourceId, type = type, userId = userId, limit = limit)
    }

    public companion object {
        /** A builder of a `BrowseEventsRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
