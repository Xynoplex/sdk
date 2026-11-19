// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Why a reader refused a frame, for its first fault: `lacks`, a member it lacks; `malformed`, a member that is not of its shape. A reader's rule (specs/src/bus/frame-cases.json). */
@Serializable
public enum class FrameRefusalReason(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("lacks")
    Lacks("lacks"),

    @SerialName("malformed")
    Malformed("malformed"),
}
