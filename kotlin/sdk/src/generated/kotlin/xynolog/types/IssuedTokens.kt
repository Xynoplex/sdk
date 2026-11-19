// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The tokens an issuer issued at the end of a sign-in. */
@Serializable
public data class IssuedTokens(
    /** The access token: short-lived, sent as a Bearer token. */
    public val access: String,
    /** The refresh token: what renews the access token without another sign-in. */
    public val refresh: String,
) {
    /** How Java makes a `IssuedTokens`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val access: String,
        private val refresh: String,
    ) {
        public fun build(): IssuedTokens = IssuedTokens(access = access, refresh = refresh)
    }

    public companion object {
        /** A builder of a `IssuedTokens` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(access: String, refresh: String): Builder = Builder(access, refresh)
    }
}
