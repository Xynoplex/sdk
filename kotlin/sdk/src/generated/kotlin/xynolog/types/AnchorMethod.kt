// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** How a quoted selection was found in a text. Which word a span is found by is reconcile's rule (specs/src/annotations/reconcile-cases.json). */
@Serializable
public enum class AnchorMethod(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("unique-match")
    UniqueMatch("unique-match"),

    @SerialName("context-recovered")
    ContextRecovered("context-recovered"),

    @SerialName("first-of-many")
    FirstOfMany("first-of-many"),

    @SerialName("fuzzy-match")
    FuzzyMatch("fuzzy-match"),
}
