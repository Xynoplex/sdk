// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId

/** Request to check the status of a job */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobStatusRequest(
    @get:JvmExposeBoxed
    public val jobId: JobId,
) {
    /** How Java makes a `JobStatusRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
    ) {
        public fun build(): JobStatusRequest = JobStatusRequest(jobId = jobId)
    }

    public companion object {
        /** A builder of a `JobStatusRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId): Builder = Builder(jobId)
    }
}
