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
 * Everything a Librarian reads at boot: nothing in it is defaulted by the Librarian. Whoever starts a Librarian writes it, from the knowledge base's stack documents, and the Librarian reads it from the path its `--config` flag names. This schema is the contract, and a Librarian needs no launcher. Started without `--config`, or with a path that names no file, the Librarian refuses to start and says which. No secret is a value here: the graph database's password, an embedding provider's key and a model provider's key are each named by the environment variable that holds it, and the Librarian's own service account is `XYNOLOG_OIDC_CLIENT_ID` and `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not validate is refused at boot, naming each failing field.
 */
@Serializable
public data class LibrarianConfig(
    @SerialName("kb")
    public val kb: KbIdentity,
    /**
     * The URL the Librarian reaches the gateway at: its route to the bus.
     */
    @SerialName("gatewayUrl")
    public val gatewayUrl: String,
    /**
     * The issuer the Librarian's service account signs in at.
     */
    @SerialName("identity")
    public val identity: LibrarianConfigIdentity,
    /**
     * Where the Archivist listens. The Librarian reads a resource's bytes from it, as its service account.
     */
    @SerialName("archivist")
    public val archivist: LibrarianConfigArchivist,
    @SerialName("graph")
    public val graph: GraphConfig,
    @SerialName("vectors")
    public val vectors: VectorsConfig,
    @SerialName("embedding")
    public val embedding: EmbeddingConfig,
    @SerialName("matcher")
    public val matcher: LibrarianEngineConfig,
    @SerialName("gatherer")
    public val gatherer: LibrarianEngineConfig,
    /**
     * The path of a model catalogue file: what each model of a provider can take, for the providers whose own APIs do not say (`google`, `openai`, `together`). A Librarian whose matcher or gatherer is of one of those providers refuses to start where the file cannot be read, and where it states nothing of that model. A Librarian with no such model does not read it.
     */
    @SerialName("modelCatalogue")
    public val modelCatalogue: String,
    /**
     * The bound on a gather.
     */
    @SerialName("gather")
    public val gather: LibrarianConfigGather,
    /**
     * The bound on a search by meaning.
     */
    @SerialName("search")
    public val search: LibrarianConfigSearch,
    /**
     * The port the Librarian answers `/health` on.
     */
    @SerialName("port")
    public val port: Long,
    @SerialName("logLevel")
    public val logLevel: LogLevel,
    @SerialName("logFormat")
    public val logFormat: LogFormat,
) {
    /** How Java makes a `LibrarianConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KbIdentity,
        private val gatewayUrl: String,
        private val identity: LibrarianConfigIdentity,
        private val archivist: LibrarianConfigArchivist,
        private val graph: GraphConfig,
        private val vectors: VectorsConfig,
        private val embedding: EmbeddingConfig,
        private val matcher: LibrarianEngineConfig,
        private val gatherer: LibrarianEngineConfig,
        private val modelCatalogue: String,
        private val gather: LibrarianConfigGather,
        private val search: LibrarianConfigSearch,
        private val port: Long,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): LibrarianConfig = LibrarianConfig(kb = kb, gatewayUrl = gatewayUrl, identity = identity, archivist = archivist, graph = graph, vectors = vectors, embedding = embedding, matcher = matcher, gatherer = gatherer, modelCatalogue = modelCatalogue, gather = gather, search = search, port = port, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `LibrarianConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KbIdentity, gatewayUrl: String, identity: LibrarianConfigIdentity, archivist: LibrarianConfigArchivist, graph: GraphConfig, vectors: VectorsConfig, embedding: EmbeddingConfig, matcher: LibrarianEngineConfig, gatherer: LibrarianEngineConfig, modelCatalogue: String, gather: LibrarianConfigGather, search: LibrarianConfigSearch, port: Long, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(kb, gatewayUrl, identity, archivist, graph, vectors, embedding, matcher, gatherer, modelCatalogue, gather, search, port, logLevel, logFormat)
    }
}
