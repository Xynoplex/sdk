// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A graph kept in a JanusGraph server, asked in Gremlin. No service has been run against one. */
@Serializable
public data class JanusGraphConfig(
    @EncodeDefault
    public val type: JanusGraphConfigType = JanusGraphConfigType.Janusgraph,
    /** The server's host. */
    public val host: String,
    /** The port its Gremlin endpoint listens on. */
    public val port: Long,
) : GraphConfig {
    /** How Java makes a `JanusGraphConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val host: String,
        private val port: Long,
    ) {
        public fun build(): JanusGraphConfig = JanusGraphConfig(host = host, port = port)
    }

    public companion object {
        /** A builder of a `JanusGraphConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(host: String, port: Long): Builder = Builder(host, port)
    }
}
