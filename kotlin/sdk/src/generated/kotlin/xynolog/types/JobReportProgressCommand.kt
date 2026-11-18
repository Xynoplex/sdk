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

/** Command to report progress on a job */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobReportProgressCommand(
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
    /** Annotation this job is attached to, when applicable. Lets the UI attach progress visuals to a specific annotation (e.g. a reference whose generation is running). */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    public val percentage: Double,
    public val progress: JobProgress? = null,
) {
    /** How Java makes a `JobReportProgressCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val jobId: JobId,
        private val jobType: JobType,
        private val percentage: Double,
    ) {
        private var userId: UserId? = null
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var progress: JobProgress? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun progress(progress: JobProgress?): Builder = apply { this.progress = progress }

        public fun build(): JobReportProgressCommand = JobReportProgressCommand(userId = userId, resourceId = resourceId, jobId = jobId, jobType = jobType, attempt = attempt, annotationId = annotationId, percentage = percentage, progress = progress)
    }

    public companion object {
        /** A builder of a `JobReportProgressCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId, jobType: JobType, percentage: Double): Builder = Builder(resourceId, jobId, jobType, percentage)
    }
}
