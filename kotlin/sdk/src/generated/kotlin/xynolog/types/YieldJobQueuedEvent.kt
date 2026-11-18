// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** A pending `yield` job, announced with what it is asked to make and without its `context`. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldJobQueuedEvent(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @EncodeDefault
    public val jobType: YieldJobQueuedEventJobType = YieldJobQueuedEventJobType.Yield,
    /** The resource the job is about. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The DID of the principal whose `job:create` created the job. */
    @get:JvmExposeBoxed
    public val userId: UserId,
    public val params: GenerationJobRequest,
) : JobQueuedEvent {
    /** How Java makes a `YieldJobQueuedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val resourceId: ResourceId,
        private val userId: UserId,
        private val params: GenerationJobRequest,
    ) {
        public fun build(): YieldJobQueuedEvent = YieldJobQueuedEvent(jobId = jobId, resourceId = resourceId, userId = userId, params = params)
    }

    public companion object {
        /** A builder of a `YieldJobQueuedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, resourceId: ResourceId, userId: UserId, params: GenerationJobRequest): Builder = Builder(jobId, resourceId, userId, params)
    }
}
