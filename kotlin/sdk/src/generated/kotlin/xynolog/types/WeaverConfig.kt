// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Everything a Weaver reads at boot: nothing in it is defaulted by the Weaver. The launcher writes it for the Weaver it starts, from the knowledge base's stack documents, and the Weaver reads it from the path its `--config` flag names (its image passes `/etc/xynolog/weaver.json`). Whoever starts a Weaver another way writes the same document: this schema is the contract, and a Weaver needs no launcher. Started without `--config`, or with a path that names no file, the Weaver refuses to start and says which. No secret is a value here: the graph database's password is named by the environment variable that holds it, and the Weaver's own service account is `XYNOLOG_OIDC_CLIENT_ID` and `XYNOLOG_OIDC_CLIENT_SECRET` in its environment. A document that does not validate is refused at boot, naming each failing field. */
@Serializable
public data class WeaverConfig(
    public val kb: KbIdentity,
    /** The URL the Weaver reaches the gateway at: its route to the bus. */
    public val gatewayUrl: String,
    /** The issuer the Weaver's service account signs in at. */
    public val identity: ServiceIdentity,
    /** Where the Archivist listens. The Weaver reads the record by position from it, and a resource's annotations, as its service account. */
    public val archivist: ServiceAddress,
    public val graph: GraphConfig,
    public val cursorsPath: CursorsPath,
    /** The port the Weaver answers `/health` on. */
    public val port: Long,
    public val logLevel: LogLevel,
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
