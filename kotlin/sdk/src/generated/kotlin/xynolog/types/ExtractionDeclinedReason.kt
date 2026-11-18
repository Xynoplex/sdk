// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Why extraction yielded nothing, by class. */
@Serializable
public enum class ExtractionDeclinedReason(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("no-text-layer")
    NoTextLayer("no-text-layer"),

    @SerialName("encrypted")
    Encrypted("encrypted"),

    @SerialName("corrupt")
    Corrupt("corrupt"),

    @SerialName("too-large")
    TooLarge("too-large"),
}
