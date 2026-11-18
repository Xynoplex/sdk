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
 * Everything the Archivist reads at boot: nothing in it is defaulted by the Archivist. The launcher writes it for the Archivist it starts, from the knowledge base's stack documents, and the Archivist reads it from the path its `--config` flag names (its image passes `/etc/xynolog/archivist.json`). Started without `--config`, or with a path that names no file, the Archivist refuses to start and says which. No secret is a value here. What the knowledge base says of itself is not here either: its name, its `site.domain` and its `git.sync` are read from the committed `.xynolog/config.yaml` of the tree at `root`. The Archivist's other inputs are the environment variables specs/src/service-environment/variables.json lists for it. A document that does not validate is refused at boot, naming each failing field.
 */
@Serializable
public data class ArchivistConfig(
    /**
     * The URL the Archivist reaches the gateway at: its only route to the bus.
     */
    @SerialName("gatewayUrl")
    public val gatewayUrl: String,
    /**
     * The issuer the Archivist's service account signs in at, and whose tokens it admits callers of its HTTP surface by.
     */
    @SerialName("identity")
    public val identity: ArchivistConfigIdentity,
    /**
     * The knowledge base's working tree: the directory holding `.xynolog/`. The event log, the content and the committed config are under it.
     */
    @SerialName("root")
    public val root: String,
    /**
     * The state volume, this knowledge base's alone: the Archivist keeps the knowledge base's views and projections in it, at its top.
     */
    @SerialName("stateHome")
    public val stateHome: String,
    /**
     * The anchored-text store, which only the Archivist mounts: the Smelter stores each entry in it over HTTP, and the Archivist serves it.
     */
    @SerialName("anchoredTextDir")
    public val anchoredTextDir: String,
    @SerialName("engines")
    public val engines: ArchivistEngines,
    /**
     * The port the Archivist's HTTP surface answers on, `/health` included.
     */
    @SerialName("port")
    public val port: Long,
    /**
     * Whether the Archivist serves the views it finds at boot instead of rebuilding them from the event log first.
     */
    @SerialName("skipRebuild")
    public val skipRebuild: Boolean,
    /**
     * The bounds on how far the staging driver may run behind the working tree, in milliseconds. A knowledge base that does not sync git stages nothing, and reads neither.
     */
    @SerialName("staging")
    public val staging: ArchivistConfigStaging,
    @SerialName("logLevel")
    public val logLevel: LogLevel,
    @SerialName("logFormat")
    public val logFormat: LogFormat,
) {
    /** How Java makes a `ArchivistConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val gatewayUrl: String,
        private val identity: ArchivistConfigIdentity,
        private val root: String,
        private val stateHome: String,
        private val anchoredTextDir: String,
        private val engines: ArchivistEngines,
        private val port: Long,
        private val skipRebuild: Boolean,
        private val staging: ArchivistConfigStaging,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): ArchivistConfig = ArchivistConfig(gatewayUrl = gatewayUrl, identity = identity, root = root, stateHome = stateHome, anchoredTextDir = anchoredTextDir, engines = engines, port = port, skipRebuild = skipRebuild, staging = staging, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `ArchivistConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(gatewayUrl: String, identity: ArchivistConfigIdentity, root: String, stateHome: String, anchoredTextDir: String, engines: ArchivistEngines, port: Long, skipRebuild: Boolean, staging: ArchivistConfigStaging, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(gatewayUrl, identity, root, stateHome, anchoredTextDir, engines, port, skipRebuild, staging, logLevel, logFormat)
    }
}
