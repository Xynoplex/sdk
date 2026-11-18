// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command the dispatcher emits, under its own service identity, immediately after it accepts a job:claim — the correlated job:claimed reply is unchanged. The Stower persists it as job:assigned. It is the one fact only the dispatcher can vouch for: which holder took which job, and who requested it. A later write citing `jobId` is checked against the holder and its `creator` derived from the requester by reading the resource's own log, with nothing outside the record. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobAssignCommand(
    /** The dispatcher's service DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** The job's resource — for a generation, the source it generates from. The assignment is persisted on this resource's log. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** DID of the claimant whose claim was accepted — the `_userId` the gateway stamped on the job:claim, restated by the dispatcher. */
    @get:JvmExposeBoxed
    public val holder: UserId,
    /** DID of the emitter of the job:create that produced this job — the `_userId` the gateway stamped on that create, restated by the dispatcher. */
    @get:JvmExposeBoxed
    public val requester: UserId,
) {
    /** How Java makes a `JobAssignCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
        private val resourceId: ResourceId,
        private val holder: UserId,
        private val requester: UserId,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): JobAssignCommand = JobAssignCommand(userId = userId, jobId = jobId, jobType = jobType, resourceId = resourceId, holder = holder, requester = requester)
    }

    public companion object {
        /** A builder of a `JobAssignCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType, resourceId: ResourceId, holder: UserId, requester: UserId): Builder = Builder(jobId, jobType, resourceId, holder, requester)
    }
}
