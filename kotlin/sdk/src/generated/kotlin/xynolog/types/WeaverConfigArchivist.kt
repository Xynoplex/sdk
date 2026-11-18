// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Where the Archivist listens. The Weaver reads the record by position from it, and a resource's annotations, as its service account. */
@Serializable
public data class WeaverConfigArchivist(
    public val host: String,
    public val port: Long,
) {
    /** How Java makes a `WeaverConfigArchivist`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val host: String,
        private val port: Long,
    ) {
        public fun build(): WeaverConfigArchivist = WeaverConfigArchivist(host = host, port = port)
    }

    public companion object {
        /** A builder of a `WeaverConfigArchivist` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(host: String, port: Long): Builder = Builder(host, port)
    }
}
