// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class ContextualSummaryResponse(
    public val summary: String,
    /** What the summary is of: the resource the annotation is on, and the annotation's entity types. */
    public val relevantFields: ContextualSummaryResponseRelevantFields,
    public val context: ContextualSummaryResponseContext,
) {
    /** How Java makes a `ContextualSummaryResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val summary: String,
        private val relevantFields: ContextualSummaryResponseRelevantFields,
        private val context: ContextualSummaryResponseContext,
    ) {
        public fun build(): ContextualSummaryResponse = ContextualSummaryResponse(summary = summary, relevantFields = relevantFields, context = context)
    }

    public companion object {
        /** A builder of a `ContextualSummaryResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(summary: String, relevantFields: ContextualSummaryResponseRelevantFields, context: ContextualSummaryResponseContext): Builder = Builder(summary, relevantFields, context)
    }
}
