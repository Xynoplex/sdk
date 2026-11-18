// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** What the summary is of: the resource the annotation is on, and the annotation's entity types. */
@Serializable
public data class ContextualSummaryResponseRelevantFields(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val resourceName: String,
    public val entityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `ContextualSummaryResponseRelevantFields`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val resourceName: String,
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        public fun build(): ContextualSummaryResponseRelevantFields = ContextualSummaryResponseRelevantFields(resourceId = resourceId, resourceName = resourceName, entityTypes = entityTypes)
    }

    public companion object {
        /** A builder of a `ContextualSummaryResponseRelevantFields` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, resourceName: String, entityTypes: kotlin.collections.List<String>): Builder = Builder(resourceId, resourceName, entityTypes)
    }
}
