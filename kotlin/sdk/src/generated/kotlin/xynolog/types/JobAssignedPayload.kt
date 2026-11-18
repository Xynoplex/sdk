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
 * Payload for job:assigned — the dispatcher's own record that it accepted a claim. Emitted by the dispatcher under its service identity after a successful job:claim (the correlated job:claimed reply is unchanged). This is the one fact only the dispatcher can vouch for: which holder took which job, and who requested it. The Stower persists it beside job:started so that a write citing `jobId` can be checked against the holder and its `creator` derived from the requester with no read outside the event log.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobAssignedPayload(
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("jobType")
    public val jobType: JobType,
    /**
     * The job's resource — for a generation, the source it generates from. Job events are scoped here.
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * DID of the emitter whose claim the dispatcher accepted. The bus stamped it on the job:claim as `_userId`; the dispatcher restates it here under its own identity.
     */
    @SerialName("holder")
    @get:JvmExposeBoxed
    public val holder: UserId,
    /**
     * DID of the emitter of the job:create that produced this job. The dispatcher restates the `_userId` the gateway stamped on that create.
     */
    @SerialName("requester")
    @get:JvmExposeBoxed
    public val requester: UserId,
) {
    /** How Java makes a `JobAssignedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
        private val resourceId: ResourceId,
        private val holder: UserId,
        private val requester: UserId,
    ) {
        public fun build(): JobAssignedPayload = JobAssignedPayload(jobId = jobId, jobType = jobType, resourceId = resourceId, holder = holder, requester = requester)
    }

    public companion object {
        /** A builder of a `JobAssignedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType, resourceId: ResourceId, holder: UserId, requester: UserId): Builder = Builder(jobId, jobType, resourceId, holder, requester)
    }
}
