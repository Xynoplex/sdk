// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a search for what a reference could refer to is told beside the reference and its context: MatchSearchRequest's other members. client/surface.json's `match.search` cases state what is sent for one left out. */
@Serializable
public data class MatchSearchOptions(
    /** Maximum number of candidate results to return */
    public val limit: Long? = null,
    /** Enable semantic similarity scoring in addition to keyword matching */
    public val useSemanticScoring: Boolean? = null,
) {
    /** How Java makes a `MatchSearchOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var limit: Long? = null
        private var useSemanticScoring: Boolean? = null

        public fun limit(limit: Long?): Builder = apply { this.limit = limit }
        public fun useSemanticScoring(useSemanticScoring: Boolean?): Builder = apply { this.useSemanticScoring = useSemanticScoring }

        public fun build(): MatchSearchOptions = MatchSearchOptions(limit = limit, useSemanticScoring = useSemanticScoring)
    }

    public companion object {
        /** A builder of a `MatchSearchOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
