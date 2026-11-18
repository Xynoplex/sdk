// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** One job as the queue stores it: the job, and when it last showed life. The dead-worker sweep reads `lastProgressAt`: a running job whose worker has reported nothing for the configured interval is presumed dead. Where the queue keeps these records is the job storage layout, specs/src/jobs/storage.json. */
@Serializable
public data class JobRecord(
    public val job: Job,
    /** When the job was created, claimed, checkpointed or last reported progress, as an ISO 8601 timestamp. */
    public val lastProgressAt: String,
) {
    /** How Java makes a `JobRecord`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val job: Job,
        private val lastProgressAt: String,
    ) {
        public fun build(): JobRecord = JobRecord(job = job, lastProgressAt = lastProgressAt)
    }

    public companion object {
        /** A builder of a `JobRecord` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(job: Job, lastProgressAt: String): Builder = Builder(job, lastProgressAt)
    }
}
