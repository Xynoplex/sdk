// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The text has the words in more than one place, and the span is the first that fits every hint the quote gave. */
@Serializable
public data class ReconciledSpanContextRecovered(
    /** The offset the span starts at, in Unicode code points from the text's start. */
    public val start: Long,
    /** The offset just past the span, in Unicode code points from the text's start. */
    public val end: Long,
    /** The words quoted. */
    public val exact: String,
    /** The text just before them. */
    public val prefix: String? = null,
    /** The text just after them. */
    public val suffix: String? = null,
    @EncodeDefault
    public val anchorMethod: ReconciledSpanContextRecoveredAnchorMethod = ReconciledSpanContextRecoveredAnchorMethod.ContextRecovered,
) : ReconciledSpan {
    /** How Java makes a `ReconciledSpanContextRecovered`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val start: Long,
        private val end: Long,
        private val exact: String,
    ) {
        private var prefix: String? = null
        private var suffix: String? = null

        public fun prefix(prefix: String?): Builder = apply { this.prefix = prefix }
        public fun suffix(suffix: String?): Builder = apply { this.suffix = suffix }

        public fun build(): ReconciledSpanContextRecovered = ReconciledSpanContextRecovered(start = start, end = end, exact = exact, prefix = prefix, suffix = suffix)
    }

    public companion object {
        /** A builder of a `ReconciledSpanContextRecovered` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(start: Long, end: Long, exact: String): Builder = Builder(start, end, exact)
    }
}
