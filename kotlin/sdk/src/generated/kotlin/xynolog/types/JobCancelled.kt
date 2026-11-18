// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A job cancelled before it concluded. */
@Serializable
public data class JobCancelled(
    @EncodeDefault
    public val status: JobCancelledStatus = JobCancelledStatus.Cancelled,
    public val metadata: JobMetadata,
    public val params: JobParams,
    /** When its claim was made; absent when it was cancelled while pending. */
    public val startedAt: String? = null,
    /** When it was cancelled. */
    public val completedAt: String,
) : Job {
    /** How Java makes a `JobCancelled`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
        private val completedAt: String,
    ) {
        private var startedAt: String? = null

        public fun startedAt(startedAt: String?): Builder = apply { this.startedAt = startedAt }

        public fun build(): JobCancelled = JobCancelled(metadata = metadata, params = params, startedAt = startedAt, completedAt = completedAt)
    }

    public companion object {
        /** A builder of a `JobCancelled` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams, completedAt: String): Builder = Builder(metadata, params, completedAt)
    }
}
