// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The bytes were declined: no text is extracted from them. */
@Serializable
public data class AnchoredTextDeclinedEntry(
    /** The entry format. */
    public val v: Long,
    /** The stamp the entry was derived under: the PDF reader's and the OCR engine's. A reader takes the entry only when it equals the stamp the Smelter last stated. */
    public val stamp: String,
    /** Why extraction yielded nothing, by class. */
    public val declined: ExtractionDeclinedReason,
) : AnchoredTextEntry {
    /** How Java makes a `AnchoredTextDeclinedEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val v: Long,
        private val stamp: String,
        private val declined: ExtractionDeclinedReason,
    ) {
        public fun build(): AnchoredTextDeclinedEntry = AnchoredTextDeclinedEntry(v = v, stamp = stamp, declined = declined)
    }

    public companion object {
        /** A builder of a `AnchoredTextDeclinedEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(v: Long, stamp: String, declined: ExtractionDeclinedReason): Builder = Builder(v, stamp, declined)
    }
}
