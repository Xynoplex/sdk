// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** How a text was extracted: a plain text taken as it is, a PDF's text layer read, a grid written as rows, a filled form's values read, or pixels read by OCR. */
@Serializable
public enum class ExtractionMethod(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("text-passthrough")
    TextPassthrough("text-passthrough"),

    @SerialName("pdf-text-layer")
    PdfTextLayer("pdf-text-layer"),

    @SerialName("table")
    Table("table"),

    @SerialName("form")
    Form("form"),

    @SerialName("ocr")
    Ocr("ocr"),
}
