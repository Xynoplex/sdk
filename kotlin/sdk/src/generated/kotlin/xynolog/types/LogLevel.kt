// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** How much a service logs: the least severe level it writes, from error, the most severe, to debug. */
@Serializable
public enum class LogLevel(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("error")
    Error("error"),

    @SerialName("warn")
    Warn("warn"),

    @SerialName("info")
    Info("info"),

    @SerialName("http")
    Http("http"),

    @SerialName("debug")
    Debug("debug"),
}
