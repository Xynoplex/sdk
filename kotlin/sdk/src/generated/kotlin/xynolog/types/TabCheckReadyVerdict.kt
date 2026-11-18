// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What checking an open resource against its knowledge base concluded. */
@Serializable
public enum class TabCheckReadyVerdict(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("ready")
    Ready("ready"),
}
