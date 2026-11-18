// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Discriminant: the endpoint is a gateway reached over HTTP. */
@Serializable
public enum class HttpEndpointKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("http")
    Http("http"),
}
