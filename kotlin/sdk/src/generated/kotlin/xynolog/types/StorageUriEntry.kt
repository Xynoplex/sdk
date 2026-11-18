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
 * One entry of the storage-uri index: the file `projections/storage-uri/<ab>/<cd>/<sha256 of the URI, hex>.json` under the state directory. It answers which resource's content is at a place in the working tree. Written as JSON indented by two spaces, `uri` first.
 */
@Serializable
public data class StorageUriEntry(
    /**
     * The `file://` URI of a place in the working tree, relative to the knowledge base's root.
     */
    @SerialName("uri")
    public val uri: String,
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `StorageUriEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val uri: String,
        private val resourceId: ResourceId,
    ) {
        public fun build(): StorageUriEntry = StorageUriEntry(uri = uri, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `StorageUriEntry` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(uri: String, resourceId: ResourceId): Builder = Builder(uri, resourceId)
    }
}
