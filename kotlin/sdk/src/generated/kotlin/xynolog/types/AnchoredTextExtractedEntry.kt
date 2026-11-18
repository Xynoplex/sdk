// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The text extracted from the bytes, where each word is on the page, and how it was extracted. */
@Serializable
public data class AnchoredTextExtractedEntry(
    /** The entry format. */
    public val v: Long,
    /** The stamp the entry was derived under: the PDF reader's and the OCR engine's. A reader takes the entry only when it equals the stamp the Smelter last stated. */
    public val stamp: String,
    /** The extracted text. */
    public val text: String,
    /** Where each word of `text` is, line by line, in reading order. */
    public val lines: kotlin.collections.List<AnchoredTextExtractedEntryLinesItem>,
    /** How the text was extracted. */
    public val method: AnchoredTextExtractedEntryMethod,
    /** PDF classification, when the source was a PDF. */
    public val pdfClass: AnchoredTextExtractedEntryPdfClass? = null,
    /** How well the engine read the pixels, when any of this text came from OCR. */
    public val ocrConfidence: AnchoredTextExtractedEntryOcrConfidence? = null,
    /** 1-indexed pages this extraction could not read — present only for partially covered documents (class C). */
    public val unreadPages: kotlin.collections.List<Long>? = null,
) : AnchoredTextEntry {
    /** How Java makes a `AnchoredTextExtractedEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val v: Long,
        private val stamp: String,
        private val text: String,
        private val lines: kotlin.collections.List<AnchoredTextExtractedEntryLinesItem>,
        private val method: AnchoredTextExtractedEntryMethod,
    ) {
        private var pdfClass: AnchoredTextExtractedEntryPdfClass? = null
        private var ocrConfidence: AnchoredTextExtractedEntryOcrConfidence? = null
        private var unreadPages: kotlin.collections.List<Long>? = null

        public fun pdfClass(pdfClass: AnchoredTextExtractedEntryPdfClass?): Builder = apply { this.pdfClass = pdfClass }
        public fun ocrConfidence(ocrConfidence: AnchoredTextExtractedEntryOcrConfidence?): Builder = apply { this.ocrConfidence = ocrConfidence }
        public fun unreadPages(unreadPages: kotlin.collections.List<Long>?): Builder = apply { this.unreadPages = unreadPages }

        public fun build(): AnchoredTextExtractedEntry = AnchoredTextExtractedEntry(v = v, stamp = stamp, text = text, lines = lines, method = method, pdfClass = pdfClass, ocrConfidence = ocrConfidence, unreadPages = unreadPages)
    }

    public companion object {
        /** A builder of a `AnchoredTextExtractedEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(v: Long, stamp: String, text: String, lines: kotlin.collections.List<AnchoredTextExtractedEntryLinesItem>, method: AnchoredTextExtractedEntryMethod): Builder = Builder(v, stamp, text, lines, method)
    }
}
