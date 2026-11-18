// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetResourceByTokenResponse(
    public val sourceResource: ResourceDescriptor,
    /** ISO 8601 timestamp when token expires */
    public val expiresAt: String,
) {
    /** How Java makes a `GetResourceByTokenResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val sourceResource: ResourceDescriptor,
        private val expiresAt: String,
    ) {
        public fun build(): GetResourceByTokenResponse = GetResourceByTokenResponse(sourceResource = sourceResource, expiresAt = expiresAt)
    }

    public companion object {
        /** A builder of a `GetResourceByTokenResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(sourceResource: ResourceDescriptor, expiresAt: String): Builder = Builder(sourceResource, expiresAt)
    }
}
