// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** One line of text: the words that share a page, a baseline and a height. */
@Serializable
public data class AnchoredTextExtractedEntryLinesItem(
    /** The page, counted from 1. */
    public val p: Long,
    /** The line's vertical position in PDF points, from the bottom of the page. */
    public val y: Double,
    /** The line's height in PDF points. */
    public val h: Double,
    /** Each word as `[x, width, start, end]`: its horizontal position and width in PDF points, and the offsets of its text in `text`, which are whole numbers of Unicode code points from the start of `text`. */
    public val words: kotlin.collections.List<kotlin.collections.List<Double>>,
) {
    /** How Java makes a `AnchoredTextExtractedEntryLinesItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val p: Long,
        private val y: Double,
        private val h: Double,
        private val words: kotlin.collections.List<kotlin.collections.List<Double>>,
    ) {
        public fun build(): AnchoredTextExtractedEntryLinesItem = AnchoredTextExtractedEntryLinesItem(p = p, y = y, h = h, words = words)
    }

    public companion object {
        /** A builder of a `AnchoredTextExtractedEntryLinesItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(p: Long, y: Double, h: Double, words: kotlin.collections.List<kotlin.collections.List<Double>>): Builder = Builder(p, y, h, words)
    }
}
