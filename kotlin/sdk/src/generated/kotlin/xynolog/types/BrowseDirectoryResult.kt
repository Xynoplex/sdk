// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of browsing a directory listing */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseDirectoryResult(
    public val response: BrowseDirectoryResultResponse,
) {
    /** How Java makes a `BrowseDirectoryResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: BrowseDirectoryResultResponse,
    ) {
        public fun build(): BrowseDirectoryResult = BrowseDirectoryResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseDirectoryResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: BrowseDirectoryResultResponse): Builder = Builder(response)
    }
}
