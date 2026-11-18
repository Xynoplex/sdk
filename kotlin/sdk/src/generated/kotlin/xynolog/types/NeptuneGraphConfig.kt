// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A graph kept in Amazon Neptune, asked in Gremlin. No service has been run against one. */
@Serializable
public data class NeptuneGraphConfig(
    @EncodeDefault
    public val type: NeptuneGraphConfigType = NeptuneGraphConfigType.Neptune,
    /** The cluster's endpoint: its host name. */
    public val endpoint: String,
    /** The port its Gremlin endpoint listens on. */
    public val port: Long,
) : GraphConfig {
    /** How Java makes a `NeptuneGraphConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val endpoint: String,
        private val port: Long,
    ) {
        public fun build(): NeptuneGraphConfig = NeptuneGraphConfig(endpoint = endpoint, port = port)
    }

    public companion object {
        /** A builder of a `NeptuneGraphConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(endpoint: String, port: Long): Builder = Builder(endpoint, port)
    }
}
