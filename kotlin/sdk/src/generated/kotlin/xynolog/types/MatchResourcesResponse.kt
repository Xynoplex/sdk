// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** One page of the resources a text search found, and which kind of answer it is. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MatchResourcesResponse(
    public val resources: kotlin.collections.List<ResourceDescriptor>,
    /** How many resources the search found in all, and not only on this page. */
    public val total: Long,
    /** How many of the resources the search found were passed over before this page, as the request stated. */
    public val offset: Long,
    /** The limit the search was made with. */
    public val limit: Long,
    /** What kind of answer this is: 'lexical' — the resources matched the query text; 'semantic' — no lexical match existed, and these resources discuss the query per the vector index. Required so every producer labels its answer; a UI can render semantic results as a different kind of page ('no title matches, but these documents discuss it'). */
    public val matchKind: MatchResourcesResponseMatchKind,
) {
    /** How Java makes a `MatchResourcesResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resources: kotlin.collections.List<ResourceDescriptor>,
        private val total: Long,
        private val offset: Long,
        private val limit: Long,
        private val matchKind: MatchResourcesResponseMatchKind,
    ) {
        public fun build(): MatchResourcesResponse = MatchResourcesResponse(resources = resources, total = total, offset = offset, limit = limit, matchKind = matchKind)
    }

    public companion object {
        /** A builder of a `MatchResourcesResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resources: kotlin.collections.List<ResourceDescriptor>, total: Long, offset: Long, limit: Long, matchKind: MatchResourcesResponseMatchKind): Builder = Builder(resources, total, offset, limit, matchKind)
    }
}
