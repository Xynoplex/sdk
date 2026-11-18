// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** Progress report from a running job. The required field is `percentage`; `message` carries the coded phase and the rest are optional job-shape fields. This is the single progress shape for every job type — annotation workers and generation alike. Terminality is signalled on `job:complete` / `job:fail`, not here. A flow that iterates a user-chosen list (entity types for references, categories for tags) reports its position as one `current`/`processed`/`total` triple, the same shape for both, so a client never needs to know which flow it is drawing. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgress(
    /** Completion percentage (0-100) */
    public val percentage: Double,
    public val message: JobProgressMessage? = null,
    /** Annotation this job is attached to, when applicable. Echoed inside JobProgress (in addition to the outer command envelope) so consumers that only see the inner progress object (e.g. what `yield.delegate` returns) can still route visual feedback to a specific annotation. */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /** What the run is working on right now. `kind` is a CODE the client renders a localized name for; `value` is KB data (an entity type, a tag category) shown verbatim — the same split as `requestParams`. Absent on flows that iterate nothing, such as generation. */
    public val current: JobProgressCurrent? = null,
    /** Items completed so far, zero-based — the item in `current` is the one after these. Paired with `total`. */
    public val processed: Long? = null,
    /** Items this run will process in all. */
    public val total: Long? = null,
    /** Entities found so far (a linking job) */
    public val entitiesFound: Long? = null,
    /** Cumulative mentions the count-verifier priced across the pieces accepted so far — the denominator for a real progress bar (found of ~expected). Approximate by nature (the count saturates on very large pieces) and monotonically growing within a run. ABSENT when the provider does not verify detection yield, or before any piece has been priced: no claim, never zero. */
    public val entitiesExpected: Long? = null,
    /** Annotations emitted so far (a linking job) */
    public val entitiesEmitted: Long? = null,
    /** Per-item results for the items already finished, for the UI's completed log. Generic across flows for the same reason `current` is. */
    public val completedItems: kotlin.collections.List<JobProgressCompletedItemsItem>? = null,
    /** Echoed job parameters for display in the progress UI. `label` is a CODE, not a sentence — the client owns the wording, same rule as the progress message. `value` is the user's own input (an entity-type list, their instructions) and is deliberately NOT translated: it is their words, not ours. */
    public val requestParams: kotlin.collections.List<JobProgressRequestParamsItem>? = null,
) : JobStoredProgress {
    /** How Java makes a `JobProgress`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val percentage: Double,
    ) {
        private var message: JobProgressMessage? = null
        private var annotationId: AnnotationId? = null
        private var current: JobProgressCurrent? = null
        private var processed: Long? = null
        private var total: Long? = null
        private var entitiesFound: Long? = null
        private var entitiesExpected: Long? = null
        private var entitiesEmitted: Long? = null
        private var completedItems: kotlin.collections.List<JobProgressCompletedItemsItem>? = null
        private var requestParams: kotlin.collections.List<JobProgressRequestParamsItem>? = null

        public fun message(message: JobProgressMessage?): Builder = apply { this.message = message }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun current(current: JobProgressCurrent?): Builder = apply { this.current = current }
        public fun processed(processed: Long?): Builder = apply { this.processed = processed }
        public fun total(total: Long?): Builder = apply { this.total = total }
        public fun entitiesFound(entitiesFound: Long?): Builder = apply { this.entitiesFound = entitiesFound }
        public fun entitiesExpected(entitiesExpected: Long?): Builder = apply { this.entitiesExpected = entitiesExpected }
        public fun entitiesEmitted(entitiesEmitted: Long?): Builder = apply { this.entitiesEmitted = entitiesEmitted }
        public fun completedItems(completedItems: kotlin.collections.List<JobProgressCompletedItemsItem>?): Builder = apply { this.completedItems = completedItems }
        public fun requestParams(requestParams: kotlin.collections.List<JobProgressRequestParamsItem>?): Builder = apply { this.requestParams = requestParams }

        public fun build(): JobProgress = JobProgress(percentage = percentage, message = message, annotationId = annotationId, current = current, processed = processed, total = total, entitiesFound = entitiesFound, entitiesExpected = entitiesExpected, entitiesEmitted = entitiesEmitted, completedItems = completedItems, requestParams = requestParams)
    }

    public companion object {
        /** A builder of a `JobProgress` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(percentage: Double): Builder = Builder(percentage)
    }
}
