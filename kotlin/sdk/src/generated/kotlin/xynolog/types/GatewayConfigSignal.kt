// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The signal plane: `in-process`, one gateway on its own fabric; or `nats`, the fabric every replica on one broker shares, which requires `servers` and a broker with JetStream. */
@Serializable
public data class GatewayConfigSignal(
    public val type: GatewayConfigSignalType,
    /** The broker's address (`host:port`, or several, comma-separated). Required for `nats`. */
    public val servers: String? = null,
    /** The environment variable holding the broker user, when the broker requires one. */
    public val userEnv: String? = null,
    /** The environment variable holding the broker password, when the broker requires one. */
    public val passwordEnv: String? = null,
) {
    /** How Java makes a `GatewayConfigSignal`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val type: GatewayConfigSignalType,
    ) {
        private var servers: String? = null
        private var userEnv: String? = null
        private var passwordEnv: String? = null

        public fun servers(servers: String?): Builder = apply { this.servers = servers }
        public fun userEnv(userEnv: String?): Builder = apply { this.userEnv = userEnv }
        public fun passwordEnv(passwordEnv: String?): Builder = apply { this.passwordEnv = passwordEnv }

        public fun build(): GatewayConfigSignal = GatewayConfigSignal(type = type, servers = servers, userEnv = userEnv, passwordEnv = passwordEnv)
    }

    public companion object {
        /** A builder of a `GatewayConfigSignal` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(type: GatewayConfigSignalType): Builder = Builder(type)
    }
}
