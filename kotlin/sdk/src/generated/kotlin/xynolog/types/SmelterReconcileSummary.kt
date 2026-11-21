// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a Smelter's reconcile came to (SMELTER.md § Reconcile), as its health reports a pass that is done (SmelterHealth's `reconcile.summary`). The first four add up to how many resources it set out to index, less any whose indexing was no longer wanted when its turn came. */
@Serializable
public data class SmelterReconcileSummary(
    /** How many resources it set out to index were indexed. */
    public val resourcesEmbedded: Long,
    /** How many were skipped, by the reason each was skipped for: a reason `smelt:settled` carries (SmeltSettled). */
    public val resourcesSkipped: kotlin.collections.Map<String, Long>,
    /** How many could not be read. */
    public val resourcesUnavailable: Long,
    /** How many failed. */
    public val resourcesFailed: Long,
    /** How many resources it planned to rewrite the entity types of. */
    public val resourcesRestamped: Long,
    /** How many resources it planned to derive the anchored text of again. */
    public val resourcesReanchored: Long,
    /** How many resources it planned to take out of the index. */
    public val resourceVectorsDeleted: Long,
    /** How many annotations it planned to index. */
    public val annotationsEmbedded: Long,
    /** How many annotations it planned to rewrite the entity types of. */
    public val annotationsRestamped: Long,
    /** How many annotations it planned to take out of the index. */
    public val annotationVectorsDeleted: Long,
    /** How many resources of the catalog have text. */
    public val resourcesEligible: Long,
    /** How many resources have points when it ends. */
    public val resourcesIndexed: Long,
) {
    /** How Java makes a `SmelterReconcileSummary`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourcesEmbedded: Long,
        private val resourcesSkipped: kotlin.collections.Map<String, Long>,
        private val resourcesUnavailable: Long,
        private val resourcesFailed: Long,
        private val resourcesRestamped: Long,
        private val resourcesReanchored: Long,
        private val resourceVectorsDeleted: Long,
        private val annotationsEmbedded: Long,
        private val annotationsRestamped: Long,
        private val annotationVectorsDeleted: Long,
        private val resourcesEligible: Long,
        private val resourcesIndexed: Long,
    ) {
        public fun build(): SmelterReconcileSummary = SmelterReconcileSummary(resourcesEmbedded = resourcesEmbedded, resourcesSkipped = resourcesSkipped, resourcesUnavailable = resourcesUnavailable, resourcesFailed = resourcesFailed, resourcesRestamped = resourcesRestamped, resourcesReanchored = resourcesReanchored, resourceVectorsDeleted = resourceVectorsDeleted, annotationsEmbedded = annotationsEmbedded, annotationsRestamped = annotationsRestamped, annotationVectorsDeleted = annotationVectorsDeleted, resourcesEligible = resourcesEligible, resourcesIndexed = resourcesIndexed)
    }

    public companion object {
        /** A builder of a `SmelterReconcileSummary` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resourcesEmbedded: Long, resourcesSkipped: kotlin.collections.Map<String, Long>, resourcesUnavailable: Long, resourcesFailed: Long, resourcesRestamped: Long, resourcesReanchored: Long, resourceVectorsDeleted: Long, annotationsEmbedded: Long, annotationsRestamped: Long, annotationVectorsDeleted: Long, resourcesEligible: Long, resourcesIndexed: Long): Builder = Builder(resourcesEmbedded, resourcesSkipped, resourcesUnavailable, resourcesFailed, resourcesRestamped, resourcesReanchored, resourceVectorsDeleted, annotationsEmbedded, annotationsRestamped, annotationVectorsDeleted, resourcesEligible, resourcesIndexed)
    }
}
