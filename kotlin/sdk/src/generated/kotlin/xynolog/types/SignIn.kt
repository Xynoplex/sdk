// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * One sign-in to a running stack's knowledge base, as the sign-in store keeps it: the tokens an issuer issued to the script client, and what a renewal and a sign-out need of that issuer, learned once at sign-in. TOKENS, never a password. An entry of <stateDir>/tokens.json (see README.md).
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class SignIn(
    /**
     * The access token: short-lived, sent as a Bearer token.
     */
    @SerialName("token")
    public val token: String,
    /**
     * The refresh token: long-lived, and what renews the access token at the issuer without another sign-in. An entry with none cannot be renewed.
     */
    @SerialName("refreshToken")
    public val refreshToken: String? = null,
    /**
     * Who signed in: the address the access token named when the sign-in was made, which is the one the gateway answers for it. For display. Absent when the token named none. A writer that renews an entry keeps it as it was.
     */
    @SerialName("email")
    public val email: String? = null,
    /**
     * When the access token was issued to this machine, RFC 3339 in UTC.
     */
    @SerialName("obtainedAt")
    public val obtainedAt: String,
    /**
     * When the access token stops working, RFC 3339 in UTC, so a reader can renew before sending a token it knows is dead. Absent when the issuer named no lifetime: the gateway's refusal is then the signal.
     */
    @SerialName("expiresAt")
    public val expiresAt: String? = null,
    /**
     * The issuer the sign-in came from: the one the access token named when the sign-in was made. A writer that renews an entry keeps it.
     */
    @SerialName("issuer")
    public val issuer: String,
    /**
     * The issuer's token endpoint, where the refresh grant is made.
     */
    @SerialName("tokenEndpoint")
    public val tokenEndpoint: String,
    /**
     * The issuer's revocation endpoint (RFC 7009), where a sign-out tells it to forget the refresh token. Absent when the issuer has none.
     */
    @SerialName("revocationEndpoint")
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

        public fun refreshToken(refreshToken: String?): Builder {
            this.refreshToken = refreshToken
            return this
        }

        public fun email(email: String?): Builder {
            this.email = email
            return this
        }

        public fun expiresAt(expiresAt: String?): Builder {
            this.expiresAt = expiresAt
            return this
        }

        public fun revocationEndpoint(revocationEndpoint: String?): Builder {
            this.revocationEndpoint = revocationEndpoint
            return this
        }

        public fun build(): SignIn = SignIn(token = token, refreshToken = refreshToken, email = email, obtainedAt = obtainedAt, expiresAt = expiresAt, issuer = issuer, tokenEndpoint = tokenEndpoint, revocationEndpoint = revocationEndpoint)
    }

    public companion object {
        /** A builder of a `SignIn` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String, obtainedAt: String, issuer: String, tokenEndpoint: String): Builder = Builder(token, obtainedAt, issuer, tokenEndpoint)
    }
}
