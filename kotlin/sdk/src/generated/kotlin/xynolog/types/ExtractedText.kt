// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A successful extraction: the anchored text plus its provenance. The 'extracted' member of ExtractionOutcome, the record the anchored-text store holds. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ExtractedText(
    /** Reading-order text of the whole resource. */
    public val text: String,
    /** Positioned runs indexing `text`, roughly one per word. */
    public val items: kotlin.collections.List<PdfTextItem>,
    /** Discriminant — both ExtractionOutcome members carry `kind`, single-valued: the category here, the detail in `method`. */
    @EncodeDefault
    public val kind: ExtractedTextKind = ExtractedTextKind.Extracted,
    /** How the text was extracted. */
    public val method: ExtractedTextMethod,
    /** PDF classification, when the source was a PDF. */
    public val pdfClass: ExtractedTextPdfClass? = null,
    /** How well the engine read the pixels, when any of this text came from OCR. */
    public val ocrConfidence: ExtractedTextOcrConfidence? = null,
    /** 1-indexed pages this extraction could not read — present only for partially covered documents (class C). */
    public val unreadPages: kotlin.collections.List<Long>? = null,
) : AnchoredTextAnswer,
    ExtractionOutcome {
    /** How Java makes a `ExtractedText`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
        private val items: kotlin.collections.List<PdfTextItem>,
        private val method: ExtractedTextMethod,
    ) {
        private var pdfClass: ExtractedTextPdfClass? = null
        private var ocrConfidence: ExtractedTextOcrConfidence? = null
        private var unreadPages: kotlin.collections.List<Long>? = null

        public fun pdfClass(pdfClass: ExtractedTextPdfClass?): Builder = apply { this.pdfClass = pdfClass }
        public fun ocrConfidence(ocrConfidence: ExtractedTextOcrConfidence?): Builder = apply { this.ocrConfidence = ocrConfidence }
        public fun unreadPages(unreadPages: kotlin.collections.List<Long>?): Builder = apply { this.unreadPages = unreadPages }

        public fun build(): ExtractedText = ExtractedText(text = text, items = items, method = method, pdfClass = pdfClass, ocrConfidence = ocrConfidence, unreadPages = unreadPages)
    }

    public companion object {
        /** A builder of a `ExtractedText` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(text: String, items: kotlin.collections.List<PdfTextItem>, method: ExtractedTextMethod): Builder = Builder(text, items, method)
    }
}
