// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId

/** Payload for job:started domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobStartedPayload(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** Annotation this job is attached to, when applicable */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    public val totalSteps: Long? = null,
) {
    /** How Java makes a `JobStartedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
    ) {
        private var annotationId: AnnotationId? = null
        private var totalSteps: Long? = null

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun totalSteps(totalSteps: Long?): Builder = apply { this.totalSteps = totalSteps }

        public fun build(): JobStartedPayload = JobStartedPayload(jobId = jobId, jobType = jobType, annotationId = annotationId, totalSteps = totalSteps)
    }

    public companion object {
        /** A builder of a `JobStartedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType): Builder = Builder(jobId, jobType)
    }
}
