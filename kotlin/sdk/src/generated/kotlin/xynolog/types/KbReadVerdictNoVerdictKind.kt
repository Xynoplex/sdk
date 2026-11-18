// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What reading the active knowledge base against its entry concluded. */
@Serializable
public enum class KbReadVerdictNoVerdictKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("no-verdict")
    NoVerdict("no-verdict"),
}
