// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The JetStream broker holding the job queue, whose layout is specs/src/jobs/storage.json. */
@Serializable
public data class DispatcherConfigQueue(
    /** The broker's address (`host:port`, or several, comma-separated). */
    public val servers: String,
    /** The environment variable holding the broker user, when the broker requires one. */
    public val userEnv: String? = null,
    /** The environment variable holding the broker password, when the broker requires one. */
    public val passwordEnv: String? = null,
) {
    /** How Java makes a `DispatcherConfigQueue`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val servers: String,
    ) {
        private var userEnv: String? = null
        private var passwordEnv: String? = null

        public fun userEnv(userEnv: String?): Builder = apply { this.userEnv = userEnv }
        public fun passwordEnv(passwordEnv: String?): Builder = apply { this.passwordEnv = passwordEnv }

        public fun build(): DispatcherConfigQueue = DispatcherConfigQueue(servers = servers, userEnv = userEnv, passwordEnv = passwordEnv)
    }

    public companion object {
        /** A builder of a `DispatcherConfigQueue` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(servers: String): Builder = Builder(servers)
    }
}
