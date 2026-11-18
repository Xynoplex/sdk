// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable
public data class BrowseProfilesResultResponse(
    /** Each profile, keyed by DID. */
    public val profiles: kotlin.collections.Map<String, Profile>,
) {
    /** How Java makes a `BrowseProfilesResultResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val profiles: kotlin.collections.Map<String, Profile>,
    ) {
        public fun build(): BrowseProfilesResultResponse = BrowseProfilesResultResponse(profiles = profiles)
    }

    public companion object {
        /** A builder of a `BrowseProfilesResultResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(profiles: kotlin.collections.Map<String, Profile>): Builder = Builder(profiles)
    }
}
