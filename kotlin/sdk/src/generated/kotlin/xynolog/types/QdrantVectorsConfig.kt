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
 * A vector index kept in a Qdrant server, asked over its REST API with a token.
 */
@Serializable
public data class QdrantVectorsConfig(
    @SerialName("type")
    @EncodeDefault
    public val type: QdrantVectorsConfigType = QdrantVectorsConfigType.Qdrant,
    /**
     * The server's host.
     */
    @SerialName("host")
    public val host: String,
    /**
     * The port its REST API listens on.
     */
    @SerialName("port")
    public val port: Long,
    /**
     * The environment variable holding the token the service presents to the server on every request, which says what of the index it may read and write. The token is never a value here.
     */
    @SerialName("tokenEnv")
    public val tokenEnv: String,
) : VectorsConfig {
    /** How Java makes a `QdrantVectorsConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val host: String,
        private val port: Long,
        private val tokenEnv: String,
    ) {
        public fun build(): QdrantVectorsConfig = QdrantVectorsConfig(host = host, port = port, tokenEnv = tokenEnv)
    }

    public companion object {
        /** A builder of a `QdrantVectorsConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(host: String, port: Long, tokenEnv: String): Builder = Builder(host, port, tokenEnv)
    }
}
