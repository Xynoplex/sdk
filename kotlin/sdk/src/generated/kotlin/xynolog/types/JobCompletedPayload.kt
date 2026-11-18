// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId

/** Payload for job:completed domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCompletedPayload(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows. */
    public val attempt: Long? = null,
    /** Annotation this job was attached to, when applicable */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    public val totalSteps: Long? = null,
    /** For detection: total entities found */
    public val foundCount: Long? = null,
    /** For generation: ID of generated resource */
    @get:JvmExposeBoxed
    public val resultResourceId: ResourceId? = null,
    /** For generation: URI of annotation that triggered generation */
    public val annotationUri: String? = null,
    /** Full result object for extensibility */
    public val result: JsonObject? = null,
    public val durability: DurabilityEvidence? = null,
) {
    /** How Java makes a `JobCompletedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
    ) {
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var totalSteps: Long? = null
        private var foundCount: Long? = null
        private var resultResourceId: ResourceId? = null
        private var annotationUri: String? = null
        private var result: JsonObject? = null
        private var durability: DurabilityEvidence? = null

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun totalSteps(totalSteps: Long?): Builder = apply { this.totalSteps = totalSteps }
        public fun foundCount(foundCount: Long?): Builder = apply { this.foundCount = foundCount }

        @JvmExposeBoxed
        public fun resultResourceId(resultResourceId: ResourceId?): Builder = apply { this.resultResourceId = resultResourceId }

        public fun annotationUri(annotationUri: String?): Builder = apply { this.annotationUri = annotationUri }
        public fun result(result: JsonObject?): Builder = apply { this.result = result }
        public fun durability(durability: DurabilityEvidence?): Builder = apply { this.durability = durability }

        public fun build(): JobCompletedPayload = JobCompletedPayload(jobId = jobId, jobType = jobType, attempt = attempt, annotationId = annotationId, totalSteps = totalSteps, foundCount = foundCount, resultResourceId = resultResourceId, annotationUri = annotationUri, result = result, durability = durability)
    }

    public companion object {
        /** A builder of a `JobCompletedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType): Builder = Builder(jobId, jobType)
    }
}
