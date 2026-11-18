// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Everything a Smelter reads at boot: nothing in it is defaulted by the Smelter. Whoever starts a Smelter writes it, from the knowledge base's stack documents, and the Smelter reads it from the path its `--config` flag names. This schema is the contract, and a Smelter needs no launcher. Started without `--config`, or with a path that names no file, the Smelter refuses to start and says which. No secret is a value here: an embedding provider's key is named by the environment variable that holds it, and the Smelter's own service account is `XYNOLOG_OIDC_CLIENT_ID` and `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not validate is refused at boot, naming each failing field. */
@Serializable
public data class SmelterConfig(
    public val kb: KbIdentity,
    /** The URL the Smelter reaches the gateway at: its route to the bus. */
    public val gatewayUrl: String,
    /** The issuer the Smelter's service account signs in at. */
    public val identity: SmelterConfigIdentity,
    /** Where the Archivist listens. The Smelter reads a resource's bytes from it, and keeps the anchored-text store there, as its service account. */
    public val archivist: SmelterConfigArchivist,
    public val embedding: EmbeddingConfig,
    public val vectors: VectorsConfig,
    /** The two numbers a text is cut by before it is embedded, both in tokens, a token being taken as four code points. */
    public val chunking: SmelterConfigChunking,
    /** How many PDFs the Smelter works on at once. Each one under way holds its bytes, a page of a scan in pixels beside the OCR process reading it, and its text and vectors, so whoever starts a Smelter sizes this with the memory it gives it. Every other resource is indexed beside them. */
    public val pdfsAtOnce: Long,
    public val cursorsPath: CursorsPath,
    /** The port the Smelter answers `/health` on. */
    public val port: Long,
    public val logLevel: LogLevel,
    public val logFormat: LogFormat,
) {
    /** How Java makes a `SmelterConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KbIdentity,
        private val gatewayUrl: String,
        private val identity: SmelterConfigIdentity,
        private val archivist: SmelterConfigArchivist,
        private val embedding: EmbeddingConfig,
        private val vectors: VectorsConfig,
        private val chunking: SmelterConfigChunking,
        private val pdfsAtOnce: Long,
        private val cursorsPath: CursorsPath,
        private val port: Long,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): SmelterConfig = SmelterConfig(kb = kb, gatewayUrl = gatewayUrl, identity = identity, archivist = archivist, embedding = embedding, vectors = vectors, chunking = chunking, pdfsAtOnce = pdfsAtOnce, cursorsPath = cursorsPath, port = port, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `SmelterConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KbIdentity, gatewayUrl: String, identity: SmelterConfigIdentity, archivist: SmelterConfigArchivist, embedding: EmbeddingConfig, vectors: VectorsConfig, chunking: SmelterConfigChunking, pdfsAtOnce: Long, cursorsPath: CursorsPath, port: Long, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(kb, gatewayUrl, identity, archivist, embedding, vectors, chunking, pdfsAtOnce, cursorsPath, port, logLevel, logFormat)
    }
}
