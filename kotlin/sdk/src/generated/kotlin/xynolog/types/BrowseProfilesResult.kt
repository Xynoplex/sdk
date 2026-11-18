// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The profiles of the principals asked after: each that has one, keyed by DID. A DID with no profile is absent, and is named by no one. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseProfilesResult(
    public val response: BrowseProfilesResultResponse,
) {
    /** How Java makes a `BrowseProfilesResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: BrowseProfilesResultResponse,
    ) {
        public fun build(): BrowseProfilesResult = BrowseProfilesResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseProfilesResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: BrowseProfilesResultResponse): Builder = Builder(response)
    }
}
