// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** One sign-in to a running stack's knowledge base, as the sign-in store keeps it: the tokens an issuer issued to the script client, and what a renewal and a sign-out need of that issuer, learned once at sign-in. TOKENS, never a password. An entry of <stateDir>/tokens.json (see README.md). */
@Serializable
@JsonIgnoreUnknownKeys
public data class SignIn(
    /** The access token: short-lived, sent as a Bearer token. */
    public val token: String,
    /** The refresh token: long-lived, and what renews the access token at the issuer without another sign-in. An entry with none cannot be renewed. */
    public val refreshToken: String? = null,
    /** Who signed in: the address the access token named when the sign-in was made, which is the one the gateway answers for it. For display. Absent when the token named none. A writer that renews an entry keeps it as it was. */
    public val email: String? = null,
    /** When the access token was issued to this machine, RFC 3339 in UTC. */
    public val obtainedAt: String,
    /** When the access token stops working, RFC 3339 in UTC, so a reader can renew before sending a token it knows is dead. Absent when the issuer named no lifetime: the gateway's refusal is then the signal. */
    public val expiresAt: String? = null,
    /** The issuer the sign-in came from: the one the access token named when the sign-in was made. A writer that renews an entry keeps it. */
    public val issuer: String,
    /** The issuer's token endpoint, where the refresh grant is made. */
    public val tokenEndpoint: String,
    /** The issuer's revocation endpoint (RFC 7009), where a sign-out tells it to forget the refresh token. Absent when the issuer has none. */
    public val revocationEndpoint: String? = null,
) {
    /** How Java makes a `SignIn`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
        private val obtainedAt: String,
        private val issuer: String,
        private val tokenEndpoint: String,
    ) {
        private var refreshToken: String? = null
        private var email: String? = null
        private var expiresAt: String? = null
        private var revocationEndpoint: String? = null

        public fun refreshToken(refreshToken: String?): Builder = apply { this.refreshToken = refreshToken }
        public fun email(email: String?): Builder = apply { this.email = email }
        public fun expiresAt(expiresAt: String?): Builder = apply { this.expiresAt = expiresAt }
        public fun revocationEndpoint(revocationEndpoint: String?): Builder = apply { this.revocationEndpoint = revocationEndpoint }

        public fun build(): SignIn = SignIn(token = token, refreshToken = refreshToken, email = email, obtainedAt = obtainedAt, expiresAt = expiresAt, issuer = issuer, tokenEndpoint = tokenEndpoint, revocationEndpoint = revocationEndpoint)
    }

    public companion object {
        /** A builder of a `SignIn` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String, obtainedAt: String, issuer: String, tokenEndpoint: String): Builder = Builder(token, obtainedAt, issuer, tokenEndpoint)
    }
}
