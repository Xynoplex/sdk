// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.UserId

/** Request for the profiles of some principals: the DIDs a reply mentions. Bounded by the question: a reader that has more asks in parts. */
@Serializable
public data class BrowseProfilesRequest(
    /** The principals asked after. */
    public val dids: kotlin.collections.List<UserId>,
) {
    /** How Java makes a `BrowseProfilesRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val dids: kotlin.collections.List<UserId>,
    ) {
        public fun build(): BrowseProfilesRequest = BrowseProfilesRequest(dids = dids)
    }

    public companion object {
        /** A builder of a `BrowseProfilesRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(dids: kotlin.collections.List<UserId>): Builder = Builder(dids)
    }
}
