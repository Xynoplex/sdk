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
 * The text extracted from the bytes, where each word is on the page, and how it was extracted.
 */
@Serializable
public data class AnchoredTextExtractedEntry(
    /**
     * The entry format.
     */
    @SerialName("v")
    public val v: Long,
    /**
     * The stamp the entry was derived under: the PDF reader's and the OCR engine's. A reader takes the entry only when it equals the stamp the Smelter last stated.
     */
    @SerialName("stamp")
    public val stamp: String,
    /**
     * The extracted text.
     */
    @SerialName("text")
    public val text: String,
    /**
     * Where each word of `text` is, line by line, in reading order.
     */
    @SerialName("lines")
    public val lines: kotlin.collections.List<AnchoredTextExtractedEntryLinesItem>,
    /**
     * How the text was extracted.
     */
    @SerialName("method")
    public val method: AnchoredTextExtractedEntryMethod,
    /**
     * PDF classification, when the source was a PDF.
     */
    @SerialName("pdfClass")
    public val pdfClass: AnchoredTextExtractedEntryPdfClass? = null,
    /**
     * How well the engine read the pixels, when any of this text came from OCR.
     */
    @SerialName("ocrConfidence")
    public val ocrConfidence: AnchoredTextExtractedEntryOcrConfidence? = null,
    /**
     * 1-indexed pages this extraction could not read — present only for partially covered documents (class C).
     */
    @SerialName("unreadPages")
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

        public fun pdfClass(pdfClass: AnchoredTextExtractedEntryPdfClass?): Builder {
            this.pdfClass = pdfClass
            return this
        }

        public fun ocrConfidence(ocrConfidence: AnchoredTextExtractedEntryOcrConfidence?): Builder {
            this.ocrConfidence = ocrConfidence
            return this
        }

        public fun unreadPages(unreadPages: kotlin.collections.List<Long>?): Builder {
            this.unreadPages = unreadPages
            return this
        }

        public fun build(): AnchoredTextExtractedEntry = AnchoredTextExtractedEntry(v = v, stamp = stamp, text = text, lines = lines, method = method, pdfClass = pdfClass, ocrConfidence = ocrConfidence, unreadPages = unreadPages)
    }

    public companion object {
        /** A builder of a `AnchoredTextExtractedEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(v: Long, stamp: String, text: String, lines: kotlin.collections.List<AnchoredTextExtractedEntryLinesItem>, method: AnchoredTextExtractedEntryMethod): Builder = Builder(v, stamp, text, lines, method)
    }
}
