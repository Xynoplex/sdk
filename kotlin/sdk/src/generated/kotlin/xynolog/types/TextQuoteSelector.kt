// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class TextQuoteSelector(
    @EncodeDefault
    public val type: TextQuoteSelectorType = TextQuoteSelectorType.TextQuoteSelector,
    public val exact: String,
    public val prefix: String? = null,
    public val suffix: String? = null,
) : Selector {
    /** How Java makes a `TextQuoteSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val exact: String,
    ) {
        private var prefix: String? = null
        private var suffix: String? = null

        public fun prefix(prefix: String?): Builder = apply { this.prefix = prefix }
        public fun suffix(suffix: String?): Builder = apply { this.suffix = suffix }

        public fun build(): TextQuoteSelector = TextQuoteSelector(exact = exact, prefix = prefix, suffix = suffix)
    }

    public companion object {
        /** A builder of a `TextQuoteSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(exact: String): Builder = Builder(exact)
    }
}
