// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The issuer this knowledge base trusts. */
@Serializable
public data class GatewayConfigIdentity(
    /** The issuer URL, exactly as tokens carry it in `iss`. */
    public val issuer: String,
    /** The claim a person's DID is built from: `did:web:<domain>:users:<its value>`. */
    public val subjectClaim: String,
) {
    /** How Java makes a `GatewayConfigIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val issuer: String,
        private val subjectClaim: String,
    ) {
        public fun build(): GatewayConfigIdentity = GatewayConfigIdentity(issuer = issuer, subjectClaim = subjectClaim)
    }

    public companion object {
        /** A builder of a `GatewayConfigIdentity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(issuer: String, subjectClaim: String): Builder = Builder(issuer, subjectClaim)
    }
}
