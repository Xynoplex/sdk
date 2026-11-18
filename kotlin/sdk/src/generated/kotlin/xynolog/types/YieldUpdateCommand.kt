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
 * Bus command to update a yielded resource's storage content.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldUpdateCommand(
    /**
     * Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this.
     */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * The caller's instruction for WHERE the bytes are — not a copy of the stored fact. The stored location lives on the resource's primary Representation (`Representation.storageUri`), which is its single home; this field is the message that puts it there. Working-tree URI, only file:// is supported (e.g. file://docs/overview.md).
     */
    @SerialName("storageUri")
    public val storageUri: String,
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("byteSize")
    public val byteSize: Long,
) {
    /** How Java makes a `YieldUpdateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val storageUri: String,
        private val contentChecksum: String,
        private val byteSize: Long,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun build(): YieldUpdateCommand = YieldUpdateCommand(userId = userId, resourceId = resourceId, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize)
    }

    public companion object {
        /** A builder of a `YieldUpdateCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, storageUri: String, contentChecksum: String, byteSize: Long): Builder = Builder(resourceId, storageUri, contentChecksum, byteSize)
    }
}
