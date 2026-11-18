// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * A successful extraction: the anchored text plus its provenance. The 'extracted' member of ExtractionOutcome, the record the anchored-text store holds.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class ExtractedText(
    /**
     * Reading-order text of the whole resource.
     */
    @SerialName("text")
    public val text: String,
    /**
     * Positioned runs indexing `text`, roughly one per word.
     */
    @SerialName("items")
    public val items: kotlin.collections.List<PdfTextItem>,
    /**
     * Discriminant — both ExtractionOutcome members carry `kind`, single-valued: the category here, the detail in `method`.
     */
    @SerialName("kind")
    @EncodeDefault
    public val kind: ExtractedTextKind = ExtractedTextKind.Extracted,
    /**
     * How the text was extracted.
     */
    @SerialName("method")
    public val method: ExtractionMethod,
    /**
     * PDF classification, when the source was a PDF.
     */
    @SerialName("pdfClass")
    public val pdfClass: PdfClass? = null,
    /**
     * How well the engine read the pixels, when any of this text came from OCR.
     */
    @SerialName("ocrConfidence")
    public val ocrConfidence: OcrConfidence? = null,
    /**
     * 1-indexed pages this extraction could not read — present only for partially covered documents (class C).
     */
    @SerialName("unreadPages")
    public val unreadPages: kotlin.collections.List<Long>? = null,
) : AnchoredTextAnswer,
    ExtractionOutcome {
    /** How Java makes a `ExtractedText`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
        private val items: kotlin.collections.List<PdfTextItem>,
        private val method: ExtractionMethod,
    ) {
        private var pdfClass: PdfClass? = null
        private var ocrConfidence: OcrConfidence? = null
        private var unreadPages: kotlin.collections.List<Long>? = null

        public fun pdfClass(pdfClass: PdfClass?): Builder {
            this.pdfClass = pdfClass
            return this
        }

        public fun ocrConfidence(ocrConfidence: OcrConfidence?): Builder {
            this.ocrConfidence = ocrConfidence
            return this
        }

        public fun unreadPages(unreadPages: kotlin.collections.List<Long>?): Builder {
            this.unreadPages = unreadPages
            return this
        }

        public fun build(): ExtractedText = ExtractedText(text = text, items = items, method = method, pdfClass = pdfClass, ocrConfidence = ocrConfidence, unreadPages = unreadPages)
    }

    public companion object {
        /** A builder of a `ExtractedText` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(text: String, items: kotlin.collections.List<PdfTextItem>, method: ExtractionMethod): Builder = Builder(text, items, method)
    }
}
