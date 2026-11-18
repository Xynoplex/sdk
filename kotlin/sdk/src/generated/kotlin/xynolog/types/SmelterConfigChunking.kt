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
 * The two numbers a text is cut by before it is embedded, both in tokens, a token being taken as four code points.
 */
@Serializable
public data class SmelterConfigChunking(
    /**
     * The size of a chunk.
     */
    @SerialName("chunkSize")
    public val chunkSize: Long,
    /**
     * How much of a chunk the next one repeats.
     */
    @SerialName("overlap")
    public val overlap: Long,
) {
    /** How Java makes a `SmelterConfigChunking`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val chunkSize: Long,
        private val overlap: Long,
    ) {
        public fun build(): SmelterConfigChunking = SmelterConfigChunking(chunkSize = chunkSize, overlap = overlap)
    }

    public companion object {
        /** A builder of a `SmelterConfigChunking` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(chunkSize: Long, overlap: Long): Builder = Builder(chunkSize, overlap)
    }
}
