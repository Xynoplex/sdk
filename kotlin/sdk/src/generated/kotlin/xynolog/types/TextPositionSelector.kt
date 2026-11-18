// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class TextPositionSelector(
    @EncodeDefault
    public val type: TextPositionSelectorType = TextPositionSelectorType.TextPositionSelector,
    /** Offset into the resource's decoded text, exactly as decoded, in Unicode code points from its start: where the selected text starts. */
    public val start: Long,
    /** Offset into the resource's decoded text, exactly as decoded, in Unicode code points from its start: just past where the selected text ends. */
    public val end: Long,
) : Selector {
    /** How Java makes a `TextPositionSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val start: Long,
        private val end: Long,
    ) {
        public fun build(): TextPositionSelector = TextPositionSelector(start = start, end = end)
    }

    public companion object {
        /** A builder of a `TextPositionSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(start: Long, end: Long): Builder = Builder(start, end)
    }
}
