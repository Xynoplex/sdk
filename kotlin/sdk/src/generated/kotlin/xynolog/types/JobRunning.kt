// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A job a worker has claimed and not yet concluded. */
@Serializable
public data class JobRunning(
    @EncodeDefault
    public val status: JobRunningStatus = JobRunningStatus.Running,
    public val metadata: JobMetadata,
    public val params: JobParams,
    /** When the claim that holds it was made, as an ISO 8601 timestamp. */
    public val startedAt: String,
    public val progress: JobStoredProgress,
) : Job {
    /** How Java makes a `JobRunning`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
        private val startedAt: String,
        private val progress: JobStoredProgress,
    ) {
        public fun build(): JobRunning = JobRunning(metadata = metadata, params = params, startedAt = startedAt, progress = progress)
    }

    public companion object {
        /** A builder of a `JobRunning` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams, startedAt: String, progress: JobStoredProgress): Builder = Builder(metadata, params, startedAt, progress)
    }
}
