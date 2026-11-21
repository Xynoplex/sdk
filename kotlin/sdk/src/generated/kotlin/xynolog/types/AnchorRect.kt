// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Where a clicked annotation's element is on the viewer's screen: its rectangle in viewport pixels, as a DOM rectangle states it. A viewer's own geometry: it rides a viewer's local frames, and a frame another participant's screen receives carries none. */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnchorRect(
    /** The rectangle's horizontal origin. */
    public val x: Double,
    /** The rectangle's vertical origin. */
    public val y: Double,
    /** The rectangle's width. */
    public val width: Double,
    /** The rectangle's height. */
    public val height: Double,
    /** The rectangle's top edge. */
    public val top: Double,
    /** The rectangle's right edge. */
    public val right: Double,
    /** The rectangle's bottom edge. */
    public val bottom: Double,
    /** The rectangle's left edge. */
    public val left: Double,
) {
    /** How Java makes a `AnchorRect`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val x: Double,
        private val y: Double,
        private val width: Double,
        private val height: Double,
        private val top: Double,
        private val right: Double,
        private val bottom: Double,
        private val left: Double,
    ) {
        public fun build(): AnchorRect = AnchorRect(x = x, y = y, width = width, height = height, top = top, right = right, bottom = bottom, left = left)
    }

    public companion object {
        /** A builder of a `AnchorRect` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(x: Double, y: Double, width: Double, height: Double, top: Double, right: Double, bottom: Double, left: Double): Builder = Builder(x, y, width, height, top, right, bottom, left)
    }
}
