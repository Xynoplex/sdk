// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A job that failed and will not be retried. */
@Serializable
public data class JobFailed(
    @EncodeDefault
    public val status: JobFailedStatus = JobFailedStatus.Failed,
    public val metadata: JobMetadata,
    public val params: JobParams,
    /** When the last claim was made; absent when it failed without one. */
    public val startedAt: String? = null,
    /** When it failed. */
    public val completedAt: String,
    /** The failure's message. */
    public val error: String,
    public val failureClass: FailureClass? = null,
) : Job {
    /** How Java makes a `JobFailed`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
        private val completedAt: String,
        private val error: String,
    ) {
        private var startedAt: String? = null
        private var failureClass: FailureClass? = null

        public fun startedAt(startedAt: String?): Builder = apply { this.startedAt = startedAt }
        public fun failureClass(failureClass: FailureClass?): Builder = apply { this.failureClass = failureClass }

        public fun build(): JobFailed = JobFailed(metadata = metadata, params = params, startedAt = startedAt, completedAt = completedAt, error = error, failureClass = failureClass)
    }

    public companion object {
        /** A builder of a `JobFailed` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams, completedAt: String, error: String): Builder = Builder(metadata, params, completedAt, error)
    }
}
