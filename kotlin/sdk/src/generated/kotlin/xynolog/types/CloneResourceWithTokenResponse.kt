// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class CloneResourceWithTokenResponse(
    /** Generated clone token */
    public val token: String,
    /** ISO 8601 timestamp when token expires */
    public val expiresAt: String,
    public val resource: ResourceDescriptor,
) {
    /** How Java makes a `CloneResourceWithTokenResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
        private val expiresAt: String,
        private val resource: ResourceDescriptor,
    ) {
        public fun build(): CloneResourceWithTokenResponse = CloneResourceWithTokenResponse(token = token, expiresAt = expiresAt, resource = resource)
    }

    public companion object {
        /** A builder of a `CloneResourceWithTokenResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String, expiresAt: String, resource: ResourceDescriptor): Builder = Builder(token, expiresAt, resource)
    }
}
