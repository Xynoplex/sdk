// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The entry a sign-in landed on, and what the person believed, so a host can set the two against each other and say when they differ. The sign-in stands either way: the knowledge base that answered is the one reached. */
@Serializable
public data class SignInOutcome(
    /** The entry the sign-in made or signed in to again. */
    public val kb: KnowledgeBase,
    /** What the person believed they were signing in to. Absent when they named nothing. */
    public val expected: Expected? = null,
) {
    /** How Java makes a `SignInOutcome`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KnowledgeBase,
    ) {
        private var expected: Expected? = null

        public fun expected(expected: Expected?): Builder = apply { this.expected = expected }

        public fun build(): SignInOutcome = SignInOutcome(kb = kb, expected = expected)
    }

    public companion object {
        /** A builder of a `SignInOutcome` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KnowledgeBase): Builder = Builder(kb)
    }
}
