// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Where the Archivist listens. The Librarian reads a resource's bytes from it, as its service account. */
@Serializable
public data class LibrarianConfigArchivist(
    public val host: String,
    public val port: Long,
) {
    /** How Java makes a `LibrarianConfigArchivist`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val host: String,
        private val port: Long,
    ) {
        public fun build(): LibrarianConfigArchivist = LibrarianConfigArchivist(host = host, port = port)
    }

    public companion object {
        /** A builder of a `LibrarianConfigArchivist` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(host: String, port: Long): Builder = Builder(host, port)
    }
}
