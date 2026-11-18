// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Everything the dispatcher reads at boot: nothing in it is defaulted by the dispatcher. The launcher writes it for the dispatcher it starts, from the knowledge base's stack documents, and the dispatcher reads it from the path its `--config` flag names (its image passes `/etc/xynolog/dispatcher.json`). Started without `--config`, or with a path that names no file, the dispatcher refuses to start and says which. Secrets are never values here: a field that needs one names the environment variable holding it. The dispatcher's other inputs are the environment variables specs/src/service-environment/variables.json lists for it, and the ones this document names. A document that does not validate is refused at boot, naming each failing field. */
@Serializable
public data class DispatcherConfig(
    public val kb: KbIdentity,
    /** The URL the dispatcher reaches the gateway at: its only route to the bus. */
    public val gatewayUrl: String,
    /** The issuer the dispatcher's service account signs in at. */
    public val identity: DispatcherConfigIdentity,
    /** The JetStream broker holding the job queue, whose layout is specs/src/jobs/storage.json. */
    public val queue: DispatcherConfigQueue,
    /** The port the dispatcher answers `/health` on. */
    public val port: Long,
    /** The queue's clocks, in milliseconds. The launcher writes the values a deployment runs with; a test harness shrinks them. */
    public val timing: DispatcherConfigTiming,
    public val logLevel: LogLevel,
    public val logFormat: LogFormat,
) {
    /** How Java makes a `DispatcherConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KbIdentity,
        private val gatewayUrl: String,
        private val identity: DispatcherConfigIdentity,
        private val queue: DispatcherConfigQueue,
        private val port: Long,
        private val timing: DispatcherConfigTiming,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): DispatcherConfig = DispatcherConfig(kb = kb, gatewayUrl = gatewayUrl, identity = identity, queue = queue, port = port, timing = timing, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `DispatcherConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KbIdentity, gatewayUrl: String, identity: DispatcherConfigIdentity, queue: DispatcherConfigQueue, port: Long, timing: DispatcherConfigTiming, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(kb, gatewayUrl, identity, queue, port, timing, logLevel, logFormat)
    }
}
