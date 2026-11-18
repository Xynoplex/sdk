// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What the gateway is reached over. */
@Serializable
public enum class HttpEndpointProtocol(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("http")
    Http("http"),

    @SerialName("https")
    Https("https"),
}
