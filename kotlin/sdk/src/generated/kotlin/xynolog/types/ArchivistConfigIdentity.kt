// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The issuer the Archivist's service account signs in at, and whose tokens it admits callers of its HTTP surface by. */
@Serializable
public data class ArchivistConfigIdentity(
    /** The issuer URL, exactly as tokens carry it in `iss`. */
    public val issuer: String,
) {
    /** How Java makes a `ArchivistConfigIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val issuer: String,
    ) {
        public fun build(): ArchivistConfigIdentity = ArchivistConfigIdentity(issuer = issuer)
    }

    public companion object {
        /** A builder of a `ArchivistConfigIdentity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(issuer: String): Builder = Builder(issuer)
    }
}
