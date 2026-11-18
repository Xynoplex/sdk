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

/** A pending `mark` job, announced with its parameters as it was created. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkJobQueuedEvent(
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @EncodeDefault
    public val jobType: MarkJobQueuedEventJobType = MarkJobQueuedEventJobType.Mark,
    /** The resource the job is about. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The DID of the principal whose `job:create` created the job. */
    @get:JvmExposeBoxed
    public val userId: UserId,
    public val params: MarkJobParams,
) : JobQueuedEvent {
    /** How Java makes a `MarkJobQueuedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val resourceId: ResourceId,
        private val userId: UserId,
        private val params: MarkJobParams,
    ) {
        public fun build(): MarkJobQueuedEvent = MarkJobQueuedEvent(jobId = jobId, resourceId = resourceId, userId = userId, params = params)
    }

    public companion object {
        /** A builder of a `MarkJobQueuedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, resourceId: ResourceId, userId: UserId, params: MarkJobParams): Builder = Builder(jobId, resourceId, userId, params)
    }
}
