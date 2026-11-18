// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * Bus command the dispatcher emits, under its own service identity, immediately after it accepts a job:claim — the correlated job:claimed reply is unchanged. The Stower persists it as job:assigned. It is the one fact only the dispatcher can vouch for: which holder took which job, and who requested it. A later write citing `jobId` is checked against the holder and its `creator` derived from the requester by reading the resource's own log, with nothing outside the record.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobAssignCommand(
    /**
     * The dispatcher's service DID, injected by the /bus/emit gateway. Clients do not set this.
     */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("jobType")
    public val jobType: JobType,
    /**
     * The job's resource — for a generation, the source it generates from. The assignment is persisted on this resource's log.
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * DID of the claimant whose claim was accepted — the `_userId` the gateway stamped on the job:claim, restated by the dispatcher.
     */
    @SerialName("holder")
    @get:JvmExposeBoxed
    public val holder: UserId,
    /**
     * DID of the emitter of the job:create that produced this job — the `_userId` the gateway stamped on that create, restated by the dispatcher.
     */
    @SerialName("requester")
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
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun build(): JobAssignCommand = JobAssignCommand(userId = userId, jobId = jobId, jobType = jobType, resourceId = resourceId, holder = holder, requester = requester)
    }

    public companion object {
        /** A builder of a `JobAssignCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType, resourceId: ResourceId, holder: UserId, requester: UserId): Builder = Builder(jobId, jobType, resourceId, holder, requester)
    }
}
