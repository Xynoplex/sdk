// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A job its worker completed. */
@Serializable
public data class JobComplete(
    @EncodeDefault
    public val status: JobCompleteStatus = JobCompleteStatus.Complete,
    public val metadata: JobMetadata,
    public val params: JobParams,
    /** When the claim that completed it was made. */
    public val startedAt: String,
    /** When it completed. */
    public val completedAt: String,
    public val result: JobStoredResult,
) : Job {
    /** How Java makes a `JobComplete`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
        private val startedAt: String,
        private val completedAt: String,
        private val result: JobStoredResult,
    ) {
        public fun build(): JobComplete = JobComplete(metadata = metadata, params = params, startedAt = startedAt, completedAt = completedAt, result = result)
    }

    public companion object {
        /** A builder of a `JobComplete` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams, startedAt: String, completedAt: String, result: JobStoredResult): Builder = Builder(metadata, params, startedAt, completedAt, result)
    }
}
