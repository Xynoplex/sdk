// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What starting an authorization-code grant is told: the knowledge base to sign in to, where the issuer sends the person back, and, re-authenticating, which registered knowledge base it is and what the person believed they chose. */
@Serializable
public data class BeginAuthorizationOptions(
    public val target: HttpEndpoint,
    /** Where the issuer sends the person back to. */
    public val redirectUri: String,
    /** The registered knowledge base being re-authenticated, rather than a new address connected to. */
    public val kbId: String? = null,
    /** The knowledge base's DID the person believed they chose: verified after, never assumed. */
    public val expectedDid: String? = null,
    /** The knowledge base's name the person believed they chose: verified after, never assumed. */
    public val expectedName: String? = null,
) {
    /** How Java makes a `BeginAuthorizationOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val target: HttpEndpoint,
        private val redirectUri: String,
    ) {
        private var kbId: String? = null
        private var expectedDid: String? = null
        private var expectedName: String? = null

        public fun kbId(kbId: String?): Builder = apply { this.kbId = kbId }
        public fun expectedDid(expectedDid: String?): Builder = apply { this.expectedDid = expectedDid }
        public fun expectedName(expectedName: String?): Builder = apply { this.expectedName = expectedName }

        public fun build(): BeginAuthorizationOptions = BeginAuthorizationOptions(target = target, redirectUri = redirectUri, kbId = kbId, expectedDid = expectedDid, expectedName = expectedName)
    }

    public companion object {
        /** A builder of a `BeginAuthorizationOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(target: HttpEndpoint, redirectUri: String): Builder = Builder(target, redirectUri)
    }
}
