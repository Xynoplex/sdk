// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A vector index kept in a Qdrant server, asked over its REST API with a token. */
@Serializable
public data class QdrantVectorsConfig(
    @EncodeDefault
    public val type: QdrantVectorsConfigType = QdrantVectorsConfigType.Qdrant,
    /** The server's host. */
    public val host: String,
    /** The port its REST API listens on. */
    public val port: Long,
    /** The environment variable holding the token the service presents to the server on every request, which says what of the index it may read and write. The token is never a value here. */
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
