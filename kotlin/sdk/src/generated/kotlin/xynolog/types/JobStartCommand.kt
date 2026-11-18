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

/** Command to start a job */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobStartCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** Annotation this job is attached to, when applicable. Set for annotation-scoped jobs like generation (from a specific reference). Unset for resource-scoped jobs like bulk reference/tag/highlight detection. */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /** Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows. */
    public val attempt: Long? = null,
) {
    /** How Java makes a `JobStartCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val jobId: JobId,
        private val jobType: JobType,
    ) {
        private var userId: UserId? = null
        private var annotationId: AnnotationId? = null
        private var attempt: Long? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }

        public fun build(): JobStartCommand = JobStartCommand(userId = userId, resourceId = resourceId, jobId = jobId, jobType = jobType, annotationId = annotationId, attempt = attempt)
    }

    public companion object {
        /** A builder of a `JobStartCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId, jobType: JobType): Builder = Builder(resourceId, jobId, jobType)
    }
}
