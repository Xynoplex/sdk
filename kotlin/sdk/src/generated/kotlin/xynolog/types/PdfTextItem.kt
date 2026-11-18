// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** One positioned text run. Coordinates are PDF points with the origin at the bottom-left of the page, Y increasing upward; the flip to canvas pixels happens in the browser. */
@Serializable
@JsonIgnoreUnknownKeys
public data class PdfTextItem(
    /** Offset into AnchoredText.text, in Unicode code points from its start, inclusive. */
    public val start: Long,
    /** Offset into AnchoredText.text, in Unicode code points from its start, exclusive. */
    public val end: Long,
    /** 1-indexed page number. */
    public val page: Long,
    public val x: Double,
    public val y: Double,
    public val width: Double,
    public val height: Double,
) {
    /** How Java makes a `PdfTextItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val start: Long,
        private val end: Long,
        private val page: Long,
        private val x: Double,
        private val y: Double,
        private val width: Double,
        private val height: Double,
    ) {
        public fun build(): PdfTextItem = PdfTextItem(start = start, end = end, page = page, x = x, y = y, width = width, height = height)
    }

    public companion object {
        /** A builder of a `PdfTextItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(start: Long, end: Long, page: Long, x: Double, y: Double, width: Double, height: Double): Builder = Builder(start, end, page, x, y, width, height)
    }
}
