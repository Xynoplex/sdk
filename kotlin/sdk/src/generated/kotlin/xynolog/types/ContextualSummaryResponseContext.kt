// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class ContextualSummaryResponseContext(
    public val before: String? = null,
    public val selected: String,
    public val after: String? = null,
) {
    /** How Java makes a `ContextualSummaryResponseContext`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val selected: String,
    ) {
        private var before: String? = null
        private var after: String? = null

        public fun before(before: String?): Builder = apply { this.before = before }
        public fun after(after: String?): Builder = apply { this.after = after }

        public fun build(): ContextualSummaryResponseContext = ContextualSummaryResponseContext(before = before, selected = selected, after = after)
    }

    public companion object {
        /** A builder of a `ContextualSummaryResponseContext` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(selected: String): Builder = Builder(selected)
    }
}
