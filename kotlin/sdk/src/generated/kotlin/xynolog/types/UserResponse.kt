// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/**
 * The authenticated principal, as this knowledge base names it.
 *
 * The `did` is the identity: it is what the bus stamps on every event, what resource creation is attributed to, and what a client must compare against to recognise its own work in the data. It is the only identifier: a row id would appear nowhere else in the system and correlate with nothing.
 *
 * The remaining fields exist to be displayed, and all of them come from the token's own claims.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class UserResponse(
    /** The authenticated principal's DID: `did:web:<domain>:agents:<subject>` for an agent, whose token's `kind` claim is `agent`, and `did:web:<domain>:users:<subject>` for a person, where the subject is the issuer claim the knowledge base names its principals by (`identity.subjectClaim`). */
    @get:JvmExposeBoxed
    public val did: UserId,
    /** The address the token carries, when it carries one: an agent's account need not have one. */
    public val email: String?,
    public val name: String?,
    public val image: String?,
    /** The knowledge base's domain: the authority the principal is named under. */
    public val domain: String,
) {
    /** How Java makes a `UserResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val did: UserId,
        private val email: String?,
        private val name: String?,
        private val image: String?,
        private val domain: String,
    ) {
        public fun build(): UserResponse = UserResponse(did = did, email = email, name = name, image = image, domain = domain)
    }

    public companion object {
        /** A builder of a `UserResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(did: UserId, email: String?, name: String?, image: String?, domain: String): Builder = Builder(did, email, name, image, domain)
    }
}
