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
 * Everything a Weaver reads at boot: nothing in it is defaulted by the Weaver. The launcher writes it for the Weaver it starts, from the knowledge base's stack documents, and the Weaver reads it from the path its `--config` flag names (its image passes `/etc/xynolog/weaver.json`). Whoever starts a Weaver another way writes the same document: this schema is the contract, and a Weaver needs no launcher. Started without `--config`, or with a path that names no file, the Weaver refuses to start and says which. No secret is a value here: the graph database's password is named by the environment variable that holds it, and the Weaver's own service account is `XYNOLOG_OIDC_CLIENT_ID` and `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not validate is refused at boot, naming each failing field.
 */
@Serializable
public data class WeaverConfig(
    @SerialName("kb")
    public val kb: KbIdentity,
    /**
     * The URL the Weaver reaches the gateway at: its route to the bus.
     */
    @SerialName("gatewayUrl")
    public val gatewayUrl: String,
    /**
     * The issuer the Weaver's service account signs in at.
     */
    @SerialName("identity")
    public val identity: ServiceIdentity,
    /**
     * Where the Archivist listens. The Weaver reads the record by position from it, and a resource's annotations, as its service account.
     */
    @SerialName("archivist")
    public val archivist: ServiceAddress,
    @SerialName("graph")
    public val graph: GraphConfig,
    @SerialName("cursorsPath")
    public val cursorsPath: CursorsPath,
    /**
     * The port the Weaver answers `/health` on.
     */
    @SerialName("port")
    public val port: Long,
    @SerialName("logLevel")
    public val logLevel: LogLevel,
    @SerialName("logFormat")
    public val logFormat: LogFormat,
) {
    /** How Java makes a `WeaverConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KbIdentity,
        private val gatewayUrl: String,
        private val identity: ServiceIdentity,
        private val archivist: ServiceAddress,
        private val graph: GraphConfig,
        private val cursorsPath: CursorsPath,
        private val port: Long,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): WeaverConfig = WeaverConfig(kb = kb, gatewayUrl = gatewayUrl, identity = identity, archivist = archivist, graph = graph, cursorsPath = cursorsPath, port = port, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `WeaverConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KbIdentity, gatewayUrl: String, identity: ServiceIdentity, archivist: ServiceAddress, graph: GraphConfig, cursorsPath: CursorsPath, port: Long, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(kb, gatewayUrl, identity, archivist, graph, cursorsPath, port, logLevel, logFormat)
    }
}
