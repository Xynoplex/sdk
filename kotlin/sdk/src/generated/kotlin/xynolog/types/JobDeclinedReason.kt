// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Why the resource could not be read. A CODE, not a sentence: the client owns the wording, so a browser renders it in the user's language and the CLI renders English terminal copy from the same value. A prose `message` composed server-side would be English everywhere. */
@Serializable
public enum class JobDeclinedReason(
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

    @SerialName("empty")
    Empty("empty"),
}
