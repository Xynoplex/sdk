// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** How the text was extracted. */
@Serializable
public enum class ExtractedTextMethod(
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
