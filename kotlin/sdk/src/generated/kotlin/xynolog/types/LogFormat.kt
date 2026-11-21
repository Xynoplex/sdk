// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** How each log line is written to stdout (service-telemetry/log-lines.json): `json`, one JSON object per line; or `simple`, a line of words followed by any metadata as JSON. */
@Serializable
public enum class LogFormat(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("json")
    Json("json"),

    @SerialName("simple")
    Simple("simple"),
}
