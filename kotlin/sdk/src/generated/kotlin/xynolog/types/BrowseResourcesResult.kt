// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of browsing resources */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseResourcesResult(
    public val response: ListResourcesResponse,
) {
    /** How Java makes a `BrowseResourcesResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: ListResourcesResponse,
    ) {
        public fun build(): BrowseResourcesResult = BrowseResourcesResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseResourcesResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: ListResourcesResponse): Builder = Builder(response)
    }
}
