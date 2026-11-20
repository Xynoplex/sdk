// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a device-authorization grant (RFC 8628) shows the person signing in: the code they enter, and where. */
@Serializable
public data class DeviceCode(
    /** The code the person enters at the issuer. */
    public val userCode: String,
    /** Where the person enters it. */
    public val verificationUri: String,
    /** Where the person goes to sign in with the code already entered, when the issuer gives one. */
    public val verificationUriComplete: String? = null,
    /** How many seconds the code stays good for. */
    public val expiresIn: Long,
) {
    /** How Java makes a `DeviceCode`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val userCode: String,
        private val verificationUri: String,
        private val expiresIn: Long,
    ) {
        private var verificationUriComplete: String? = null

        public fun verificationUriComplete(verificationUriComplete: String?): Builder = apply { this.verificationUriComplete = verificationUriComplete }

        public fun build(): DeviceCode = DeviceCode(userCode = userCode, verificationUri = verificationUri, verificationUriComplete = verificationUriComplete, expiresIn = expiresIn)
    }

    public companion object {
        /** A builder of a `DeviceCode` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(userCode: String, verificationUri: String, expiresIn: Long): Builder = Builder(userCode, verificationUri, expiresIn)
    }
}
