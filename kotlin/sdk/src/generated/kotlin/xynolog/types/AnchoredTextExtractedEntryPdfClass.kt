// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** PDF classification, when the source was a PDF. */
@Serializable
public enum class AnchoredTextExtractedEntryPdfClass(
    /** The value as the wire spells it. */
    public val value: String,
) {
    A("A"),
    B("B"),
    C("C"),
    D("D"),
    E("E"),
    F("F"),
    G("G"),
}
