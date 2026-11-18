// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The issuer the Weaver's service account signs in at. */
@Serializable
public data class WeaverConfigIdentity(
    /** The issuer URL, exactly as tokens carry it in `iss`. */
    public val issuer: String,
) {
    /** How Java makes a `WeaverConfigIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val issuer: String,
    ) {
        public fun build(): WeaverConfigIdentity = WeaverConfigIdentity(issuer = issuer)
    }

    public companion object {
        /** A builder of a `WeaverConfigIdentity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(issuer: String): Builder = Builder(issuer)
    }
}
