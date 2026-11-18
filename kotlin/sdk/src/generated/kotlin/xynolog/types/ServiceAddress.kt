// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The host and port a service listens at. */
@Serializable
public data class ServiceAddress(
    public val host: String,
    public val port: Long,
) {
    /** How Java makes a `ServiceAddress`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val host: String,
        private val port: Long,
    ) {
        public fun build(): ServiceAddress = ServiceAddress(host = host, port = port)
    }

    public companion object {
        /** A builder of a `ServiceAddress` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(host: String, port: Long): Builder = Builder(host, port)
    }
}
