// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.JobId

/** The job it holds, or null. */
@Serializable
public data class WorkerEngineHealthActiveJob(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val type: JobType,
    /** When it was handed the job. */
    public val since: String,
) {
    /** How Java makes a `WorkerEngineHealthActiveJob`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val type: JobType,
        private val since: String,
    ) {
        public fun build(): WorkerEngineHealthActiveJob = WorkerEngineHealthActiveJob(jobId = jobId, type = type, since = since)
    }

    public companion object {
        /** A builder of a `WorkerEngineHealthActiveJob` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, type: JobType, since: String): Builder = Builder(jobId, type, since)
    }
}
