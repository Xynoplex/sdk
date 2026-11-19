// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Words of a text, as a selection quotes them: the words themselves, and maybe the text just before and just after them, which tell apart the places they occur. */
@Serializable
public data class QuotedText(
    /** The words quoted. */
    public val exact: String,
    /** The text just before them. */
    public val prefix: String? = null,
    /** The text just after them. */
    public val suffix: String? = null,
) {
    /** How Java makes a `QuotedText`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val exact: String,
    ) {
        private var prefix: String? = null
        private var suffix: String? = null

        public fun prefix(prefix: String?): Builder = apply { this.prefix = prefix }
        public fun suffix(suffix: String?): Builder = apply { this.suffix = suffix }

        public fun build(): QuotedText = QuotedText(exact = exact, prefix = prefix, suffix = suffix)
    }

    public companion object {
        /** A builder of a `QuotedText` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(exact: String): Builder = Builder(exact)
    }
}
