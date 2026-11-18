// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class MediaTokenResponse(
    /** Short-lived media token for use as ?token= query parameter on resource URLs */
    public val token: String,
) {
    /** How Java makes a `MediaTokenResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
    ) {
        public fun build(): MediaTokenResponse = MediaTokenResponse(token = token)
    }

    public companion object {
        /** A builder of a `MediaTokenResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String): Builder = Builder(token)
    }
}
