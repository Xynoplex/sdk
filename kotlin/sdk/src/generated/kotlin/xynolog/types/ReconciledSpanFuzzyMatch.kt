// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The text has the words nowhere, and a looser search found the span: `matchQuality` names which. */
@Serializable
public data class ReconciledSpanFuzzyMatch(
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
    public val anchorMethod: ReconciledSpanFuzzyMatchAnchorMethod = ReconciledSpanFuzzyMatchAnchorMethod.FuzzyMatch,
    public val matchQuality: MatchQuality,
) : ReconciledSpan {
    /** How Java makes a `ReconciledSpanFuzzyMatch`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val start: Long,
        private val end: Long,
        private val exact: String,
        private val matchQuality: MatchQuality,
    ) {
        private var prefix: String? = null
        private var suffix: String? = null

        public fun prefix(prefix: String?): Builder = apply { this.prefix = prefix }
        public fun suffix(suffix: String?): Builder = apply { this.suffix = suffix }

        public fun build(): ReconciledSpanFuzzyMatch = ReconciledSpanFuzzyMatch(start = start, end = end, exact = exact, prefix = prefix, suffix = suffix, matchQuality = matchQuality)
    }

    public companion object {
        /** A builder of a `ReconciledSpanFuzzyMatch` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(start: Long, end: Long, exact: String, matchQuality: MatchQuality): Builder = Builder(start, end, exact, matchQuality)
    }
}
