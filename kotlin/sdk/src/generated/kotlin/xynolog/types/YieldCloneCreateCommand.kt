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
 * Bus command to create a cloned resource from a clone token. Bytes are stored by the upload path BEFORE this command is emitted, because bytes travel over HTTP and never over the bus — the command carries the storage coordinates, never content.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldCloneCreateCommand(
    /**
     * Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this.
     */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @SerialName("token")
    public val token: String,
    @SerialName("name")
    public val name: String,
    /**
     * Where the caller already wrote the clone's bytes — an instruction, not a copy of the stored fact (that lives on the primary Representation). Bytes are stored through the byte door BEFORE this command is sent, so this names an existing file. Working-tree URI, only file:// is supported.
     */
    @SerialName("storageUri")
    public val storageUri: String,
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("byteSize")
    public val byteSize: Long,
    @SerialName("format")
    public val format: ContentFormat,
    @SerialName("archiveOriginal")
    public val archiveOriginal: Boolean? = null,
) {
    /** How Java makes a `YieldCloneCreateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
        private val name: String,
        private val storageUri: String,
        private val contentChecksum: String,
        private val byteSize: Long,
        private val format: ContentFormat,
    ) {
        private var userId: UserId? = null
        private var archiveOriginal: Boolean? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun archiveOriginal(archiveOriginal: Boolean?): Builder {
            this.archiveOriginal = archiveOriginal
            return this
        }

        public fun build(): YieldCloneCreateCommand = YieldCloneCreateCommand(userId = userId, token = token, name = name, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize, format = format, archiveOriginal = archiveOriginal)
    }

    public companion object {
        /** A builder of a `YieldCloneCreateCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String, name: String, storageUri: String, contentChecksum: String, byteSize: Long, format: ContentFormat): Builder = Builder(token, name, storageUri, contentChecksum, byteSize, format)
    }
}
