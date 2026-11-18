// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.UserId

/** Who the knowledge base at an address says it is, asked with a token just issued, before any entry is made for it. */
@Serializable
public data class ConnectionIdentity(
    /** The did it reports for itself. */
    @get:JvmExposeBoxed
    public val did: UserId,
    /** What it says of itself. */
    public val description: KbDescription,
) {
    /** How Java makes a `ConnectionIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val did: UserId,
        private val description: KbDescription,
    ) {
        public fun build(): ConnectionIdentity = ConnectionIdentity(did = did, description = description)
    }

    public companion object {
        /** A builder of a `ConnectionIdentity` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(did: UserId, description: KbDescription): Builder = Builder(did, description)
    }
}
