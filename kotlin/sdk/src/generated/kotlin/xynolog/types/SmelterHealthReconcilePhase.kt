// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
public enum class SmelterHealthReconcilePhase(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("pending")
    Pending("pending"),

    @SerialName("running")
    Running("running"),

    @SerialName("done")
    Done("done"),

    @SerialName("failed")
    Failed("failed"),
}
