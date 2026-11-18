// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What reading the active knowledge base against its entry concluded. */
@Serializable
public enum class KbReadKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("recorded")
    Recorded("recorded"),

    @SerialName("conflict")
    Conflict("conflict"),

    @SerialName("no-verdict")
    NoVerdict("no-verdict"),
}
