// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The class a PDF is sorted into, which decides how its text is read. smelter/extraction-cases.json states what each class is. */
@Serializable
public enum class PdfClass(
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
