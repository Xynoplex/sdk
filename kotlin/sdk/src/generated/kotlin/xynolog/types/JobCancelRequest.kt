// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId

/** Request to cancel one job, named by its id. A pending job is cancelled immediately by the dispatcher. A running job is cancelled only by the worker that holds it: the worker stops its work and settles the job with `job:cancel` (JobCancelCommand). The queue is never made to yank a running job out from under a live worker. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCancelRequest(
    @get:JvmExposeBoxed
    public val jobId: JobId,
) {
    /** How Java makes a `JobCancelRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
    ) {
        public fun build(): JobCancelRequest = JobCancelRequest(jobId = jobId)
    }

    public companion object {
        /** A builder of a `JobCancelRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId): Builder = Builder(jobId)
    }
}
