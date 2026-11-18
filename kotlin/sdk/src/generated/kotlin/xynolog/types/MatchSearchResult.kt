// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** Search results payload emitted on match:search-results SSE channel. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MatchSearchResult(
    @get:JvmExposeBoxed
    public val referenceId: AnnotationId,
    /** The scored candidates, best first. */
    public val response: kotlin.collections.List<ScoredResource>,
) {
    /** How Java makes a `MatchSearchResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val referenceId: AnnotationId,
        private val response: kotlin.collections.List<ScoredResource>,
    ) {
        public fun build(): MatchSearchResult = MatchSearchResult(referenceId = referenceId, response = response)
    }

    public companion object {
        /** A builder of a `MatchSearchResult` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(referenceId: AnnotationId, response: kotlin.collections.List<ScoredResource>): Builder = Builder(referenceId, response)
    }
}
