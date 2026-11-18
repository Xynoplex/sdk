// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of browsing events for a resource */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseEventsResult(
    public val response: GetEventsResponse,
) {
    /** How Java makes a `BrowseEventsResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: GetEventsResponse,
    ) {
        public fun build(): BrowseEventsResult = BrowseEventsResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseEventsResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: GetEventsResponse): Builder = Builder(response)
    }
}
