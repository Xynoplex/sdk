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
 * A write of an anchored-text entry for the bytes of one resource: what the Smelter derived from them, and their checksum. The Archivist files the entry under the checksum, so every resource whose bytes those are has it, and refuses the write when the resource's first representation has other bytes.
 */
@Serializable
public data class AnchoredTextWrite(
    /**
     * The SHA-256 of the bytes the text was derived from, as 64 lower-case hexadecimal digits: the key the entry is filed under.
     */
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("entry")
    public val entry: AnchoredTextEntry,
) {
    /** How Java makes a `AnchoredTextWrite`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val contentChecksum: String,
        private val entry: AnchoredTextEntry,
    ) {
        public fun build(): AnchoredTextWrite = AnchoredTextWrite(contentChecksum = contentChecksum, entry = entry)
    }

    public companion object {
        /** A builder of a `AnchoredTextWrite` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(contentChecksum: String, entry: AnchoredTextEntry): Builder = Builder(contentChecksum, entry)
    }
}
