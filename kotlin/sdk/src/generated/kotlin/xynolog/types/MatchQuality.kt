// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Which looser search found a quoted selection, stated of a span whose `anchorMethod` is `fuzzy-match` and only then. Which search finds it is reconcile's rule (specs/src/annotations/reconcile-cases.json). */
@Serializable
public enum class MatchQuality(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("normalized")
    Normalized("normalized"),

    @SerialName("case-insensitive")
    CaseInsensitive("case-insensitive"),

    @SerialName("fuzzy")
    Fuzzy("fuzzy"),
}
