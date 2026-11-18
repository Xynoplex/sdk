// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of searching resources by text */
@Serializable
@JsonIgnoreUnknownKeys
public data class MatchResourcesResult(
    public val response: MatchResourcesResponse,
) {
    /** How Java makes a `MatchResourcesResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: MatchResourcesResponse,
    ) {
        public fun build(): MatchResourcesResult = MatchResourcesResult(response = response)
    }

    public companion object {
        /** A builder of a `MatchResourcesResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: MatchResourcesResponse): Builder = Builder(response)
    }
}
