// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Text paired with the geometry that indexes it — the minimum needed to turn a range of the text, two offsets counted in Unicode code points, into a selection, or a rectangle into a quote. Whole-resource: a producer iterates page by page, but every consumer wants one map. */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnchoredText(
    /** Reading-order text of the whole resource. */
    public val text: String,
    /** Positioned runs indexing `text`, roughly one per word. */
    public val items: kotlin.collections.List<PdfTextItem>,
) {
    /** How Java makes a `AnchoredText`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
        private val items: kotlin.collections.List<PdfTextItem>,
    ) {
        public fun build(): AnchoredText = AnchoredText(text = text, items = items)
    }

    public companion object {
        /** A builder of a `AnchoredText` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(text: String, items: kotlin.collections.List<PdfTextItem>): Builder = Builder(text, items)
    }
}
