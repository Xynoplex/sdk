// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId
import xynolog.identifiers.UserId

@Serializable
@JsonIgnoreUnknownKeys
public data class JobStatusResponse(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val type: JobType,
    public val status: JobStatusResponseStatus,
    @get:JvmExposeBoxed
    public val userId: UserId,
    public val created: String,
    public val startedAt: String? = null,
    public val completedAt: String? = null,
    public val error: String? = null,
    public val failureClass: FailureClass? = null,
    public val progress: JobStoredProgress? = null,
    public val result: JobStoredResult? = null,
) {
    /** How Java makes a `JobStatusResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val type: JobType,
        private val status: JobStatusResponseStatus,
        private val userId: UserId,
        private val created: String,
    ) {
        private var startedAt: String? = null
        private var completedAt: String? = null
        private var error: String? = null
        private var failureClass: FailureClass? = null
        private var progress: JobStoredProgress? = null
        private var result: JobStoredResult? = null

        public fun startedAt(startedAt: String?): Builder = apply { this.startedAt = startedAt }
        public fun completedAt(completedAt: String?): Builder = apply { this.completedAt = completedAt }
        public fun error(error: String?): Builder = apply { this.error = error }
        public fun failureClass(failureClass: FailureClass?): Builder = apply { this.failureClass = failureClass }
        public fun progress(progress: JobStoredProgress?): Builder = apply { this.progress = progress }
        public fun result(result: JobStoredResult?): Builder = apply { this.result = result }

        public fun build(): JobStatusResponse = JobStatusResponse(jobId = jobId, type = type, status = status, userId = userId, created = created, startedAt = startedAt, completedAt = completedAt, error = error, failureClass = failureClass, progress = progress, result = result)
    }

    public companion object {
        /** A builder of a `JobStatusResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, type: JobType, status: JobStatusResponseStatus, userId: UserId, created: String): Builder = Builder(jobId, type, status, userId, created)
    }
}
