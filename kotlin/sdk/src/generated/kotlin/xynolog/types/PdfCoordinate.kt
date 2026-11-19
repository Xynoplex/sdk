// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** A rectangle on a page of a PDF, in PDF points, from the page's bottom-left corner with y increasing upward: what an RFC 3778 fragment selector names. */
@Serializable
public data class PdfCoordinate(
    /** The page the rectangle is on. */
    public val page: Long,
    /** The rectangle's x. */
    public val x: Double,
    /** The rectangle's y. */
    public val y: Double,
    /** The rectangle's width. */
    public val width: Double,
    /** The rectangle's height. */
    public val height: Double,
) {
    /** How Java makes a `PdfCoordinate`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val page: Long,
        private val x: Double,
        private val y: Double,
        private val width: Double,
        private val height: Double,
    ) {
        public fun build(): PdfCoordinate = PdfCoordinate(page = page, x = x, y = y, width = width, height = height)
    }

    public companion object {
        /** A builder of a `PdfCoordinate` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(page: Long, x: Double, y: Double, width: Double, height: Double): Builder = Builder(page, x, y, width, height)
    }
}
