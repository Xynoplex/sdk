// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Why a session ended: `expired`, the issuer refused to renew its token; `refused`, the gateway refused a token its issuer had just issued. */
@Serializable
public enum class SessionEndReason(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("expired")
    Expired("expired"),

    @SerialName("refused")
    Refused("refused"),
}
