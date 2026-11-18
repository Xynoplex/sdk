// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Discriminant: the endpoint is in the host process. */
@Serializable
public enum class LocalEndpointKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("local")
    Local("local"),
}
