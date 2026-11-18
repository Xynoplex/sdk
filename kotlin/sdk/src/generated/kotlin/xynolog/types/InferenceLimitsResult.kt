// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The inference limits one service discovered for the engines it holds a client for. An engine whose discovery is currently unavailable is absent. */
@Serializable
@JsonIgnoreUnknownKeys
public data class InferenceLimitsResult(
    public val response: InferenceLimitsResultResponse,
) {
    /** How Java makes a `InferenceLimitsResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: InferenceLimitsResultResponse,
    ) {
        public fun build(): InferenceLimitsResult = InferenceLimitsResult(response = response)
    }

    public companion object {
        /** A builder of a `InferenceLimitsResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: InferenceLimitsResultResponse): Builder = Builder(response)
    }
}
