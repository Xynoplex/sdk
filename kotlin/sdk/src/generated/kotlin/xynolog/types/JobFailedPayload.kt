// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId

/** Payload for the job:failed domain event — a permanent fact of the resource, not operational state. It carries the judgments the worker COMPUTED, not just its message: at the log they are otherwise unrecoverable, the only remaining witness being a flattened English string. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobFailedPayload(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows. */
    public val attempt: Long? = null,
    /** Annotation this job was attached to, when applicable */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    public val error: String,
    public val failureClass: FailureClass? = null,
    /** Whether the worker computed that the queue would re-queue this job (same predicate the queue applies, `willRetryAfter`). Absent means the worker stated nothing. Without it a reader of the log cannot tell a run recovering across several job:failed events from that many dead jobs. */
    public val willRetry: Boolean? = null,
    public val durability: DurabilityEvidence? = null,
) {
    /** How Java makes a `JobFailedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
        private val error: String,
    ) {
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var failureClass: FailureClass? = null
        private var willRetry: Boolean? = null
        private var durability: DurabilityEvidence? = null

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun failureClass(failureClass: FailureClass?): Builder = apply { this.failureClass = failureClass }
        public fun willRetry(willRetry: Boolean?): Builder = apply { this.willRetry = willRetry }
        public fun durability(durability: DurabilityEvidence?): Builder = apply { this.durability = durability }

        public fun build(): JobFailedPayload = JobFailedPayload(jobId = jobId, jobType = jobType, attempt = attempt, annotationId = annotationId, error = error, failureClass = failureClass, willRetry = willRetry, durability = durability)
    }

    public companion object {
        /** A builder of a `JobFailedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType, error: String): Builder = Builder(jobId, jobType, error)
    }
}
