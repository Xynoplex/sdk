// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Everything the Archivist reads at boot: nothing in it is defaulted by the Archivist. The launcher writes it for the Archivist it starts, from the knowledge base's stack documents, and the Archivist reads it from the path its `--config` flag names (its image passes `/etc/xynolog/archivist.json`). Started without `--config`, or with a path that names no file, the Archivist refuses to start and says which. No secret is a value here. What the knowledge base says of itself is not here either: its name, its `site.domain` and its `git.sync` are read from the committed `.xynolog/config.yaml` of the tree at `root`. The Archivist's other inputs are the environment variables specs/src/service-environment/variables.json lists for it. A document that does not validate is refused at boot, naming each failing field. */
@Serializable
public data class ArchivistConfig(
    /** The URL the Archivist reaches the gateway at: its only route to the bus. */
    public val gatewayUrl: String,
    /** The issuer the Archivist's service account signs in at, and whose tokens it admits callers of its HTTP surface by. */
    public val identity: ArchivistConfigIdentity,
    /** The knowledge base's working tree: the directory holding `.xynolog/`. The event log, the content and the committed config are under it. */
    public val root: String,
    /** The state volume, this knowledge base's alone: the Archivist keeps the knowledge base's views and projections in it, at its top. */
    public val stateHome: String,
    /** The anchored-text store, which only the Archivist mounts: the Smelter stores each entry in it over HTTP, and the Archivist serves it. */
    public val anchoredTextDir: String,
    public val engines: ArchivistEngines,
    /** The port the Archivist's HTTP surface answers on, `/health` included. */
    public val port: Long,
    /** Whether the Archivist serves the views it finds at boot instead of rebuilding them from the event log first. */
    public val skipRebuild: Boolean,
    /** The bounds on how far the staging driver may run behind the working tree, in milliseconds. A knowledge base that does not sync git stages nothing, and reads neither. */
    public val staging: ArchivistConfigStaging,
    public val logLevel: LogLevel,
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
