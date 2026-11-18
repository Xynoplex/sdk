// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What the credential stored for a knowledge base says, read without asking anyone: `authenticated`, a token is stored and has not expired; `expired`, a token is stored and has expired; `signed-out`, nothing is stored. */
@Serializable
public enum class KbSessionStatus(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("authenticated")
    Authenticated("authenticated"),

    @SerialName("expired")
    Expired("expired"),

    @SerialName("signed-out")
    SignedOut("signed-out"),
}
