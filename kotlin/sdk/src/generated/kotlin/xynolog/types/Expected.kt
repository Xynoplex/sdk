// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a person believed they were signing in to: the did and the name of the row they clicked, or of the entry they signed in to again. */
@Serializable
public data class Expected(
    /** The did they believed it has. */
    public val did: String,
    /** The name they believed it has. Absent when they had none. */
    public val name: String? = null,
) {
    /** How Java makes a `Expected`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val did: String,
    ) {
        private var name: String? = null

        public fun name(name: String?): Builder = apply { this.name = name }

        public fun build(): Expected = Expected(did = did, name = name)
    }

    public companion object {
        /** A builder of a `Expected` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(did: String): Builder = Builder(did)
    }
}
