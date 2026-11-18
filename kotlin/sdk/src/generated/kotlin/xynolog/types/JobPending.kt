// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A job waiting for a worker to claim it. */
@Serializable
public data class JobPending(
    @EncodeDefault
    public val status: JobPendingStatus = JobPendingStatus.Pending,
    public val metadata: JobMetadata,
    public val params: JobParams,
) : Job {
    /** How Java makes a `JobPending`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
    ) {
        public fun build(): JobPending = JobPending(metadata = metadata, params = params)
    }

    public companion object {
        /** A builder of a `JobPending` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams): Builder = Builder(metadata, params)
    }
}
