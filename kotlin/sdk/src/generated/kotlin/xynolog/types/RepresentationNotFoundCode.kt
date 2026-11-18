// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** A machine-readable class, when the route defines one. */
@Serializable
public enum class RepresentationNotFoundCode(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("resource")
    Resource("resource"),

    @SerialName("representation")
    Representation("representation"),
}
