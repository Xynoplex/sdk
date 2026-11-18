// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Command to mark a job as failed */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobFailCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows. */
    public val attempt: Long? = null,
    /** Annotation this job is attached to, when applicable. Lets the UI route failure feedback (error toast, revert state) to a specific annotation. */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    public val error: String,
    /** Entity-type units whose annotations were fully emitted before this failure (checkpointed resume). The queue records them on the retried job's metadata; a retried claim skips them so completed work is neither redone nor duplicated. */
    public val completedUnits: kotlin.collections.List<String>? = null,
    /** The furthest each unit begun got, keyed by unit, with what it had counted there — the grain `completedUnits` cannot express. A unit named in `completedUnits` is stated here too, by the cursor it ended at: a later attempt skips it whole and counts it by that cursor. A cursor never says a unit is finished; only `completedUnits` does. Merged monotonically per unit, finished or not: a stale snapshot must never move a cursor backward. */
    public val unitCursors: kotlin.collections.Map<String, UnitCursor>? = null,
    public val failureClass: FailureClass? = null,
    /** Whether the queue will re-queue this job for another attempt. Computed by the worker from the SAME rule the queue applies when it takes the failure (specs/src/jobs/retry-cases.json, which every SDK and the dispatcher run) using the retry budget carried on the claimed record. FALSE (or absent) means this failure is TERMINAL: a client's job-watch stream ends here. TRUE means the work continues on a fresh attempt — the failure is an event, not the end, and a stream that terminated on it would report a recovering run as a failed one. */
    public val willRetry: Boolean? = null,
    public val durability: DurabilityEvidence? = null,
) {
    /** How Java makes a `JobFailCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val jobId: JobId,
        private val jobType: JobType,
        private val error: String,
    ) {
        private var userId: UserId? = null
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var completedUnits: kotlin.collections.List<String>? = null
        private var unitCursors: kotlin.collections.Map<String, UnitCursor>? = null
        private var failureClass: FailureClass? = null
        private var willRetry: Boolean? = null
        private var durability: DurabilityEvidence? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun completedUnits(completedUnits: kotlin.collections.List<String>?): Builder = apply { this.completedUnits = completedUnits }
        public fun unitCursors(unitCursors: kotlin.collections.Map<String, UnitCursor>?): Builder = apply { this.unitCursors = unitCursors }
        public fun failureClass(failureClass: FailureClass?): Builder = apply { this.failureClass = failureClass }
        public fun willRetry(willRetry: Boolean?): Builder = apply { this.willRetry = willRetry }
        public fun durability(durability: DurabilityEvidence?): Builder = apply { this.durability = durability }

        public fun build(): JobFailCommand = JobFailCommand(userId = userId, resourceId = resourceId, jobId = jobId, jobType = jobType, attempt = attempt, annotationId = annotationId, error = error, completedUnits = completedUnits, unitCursors = unitCursors, failureClass = failureClass, willRetry = willRetry, durability = durability)
    }

    public companion object {
        /** A builder of a `JobFailCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId, jobType: JobType, error: String): Builder = Builder(resourceId, jobId, jobType, error)
    }
}
