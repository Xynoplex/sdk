// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a completed sign-in learned, as a registry is handed it to record: where it was, who the knowledge base there says it is, the tokens, and what the person believed they were signing in to. */
@Serializable
public data class SignedIn(
    /** Where the sign-in was. */
    public val endpoint: KbEndpoint,
    /** What the knowledge base said of itself, asked with the new token. */
    public val description: KbDescription,
    /** The tokens, as a registry keeps them. */
    public val session: StoredSession,
    /** The registered knowledge base the person signed in to again. Absent when it is none. */
    public val kbId: String? = null,
    /** The did of what the person believed they clicked. Absent when they named nothing. */
    public val expectedDid: String? = null,
    /** The name of what the person believed they clicked. Absent when they named nothing. */
    public val expectedName: String? = null,
) {
    /** How Java makes a `SignedIn`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val endpoint: KbEndpoint,
        private val description: KbDescription,
        private val session: StoredSession,
    ) {
        private var kbId: String? = null
        private var expectedDid: String? = null
        private var expectedName: String? = null

        public fun kbId(kbId: String?): Builder = apply { this.kbId = kbId }
        public fun expectedDid(expectedDid: String?): Builder = apply { this.expectedDid = expectedDid }
        public fun expectedName(expectedName: String?): Builder = apply { this.expectedName = expectedName }

        public fun build(): SignedIn = SignedIn(endpoint = endpoint, description = description, session = session, kbId = kbId, expectedDid = expectedDid, expectedName = expectedName)
    }

    public companion object {
        /** A builder of a `SignedIn` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(endpoint: KbEndpoint, description: KbDescription, session: StoredSession): Builder = Builder(endpoint, description, session)
    }
}
