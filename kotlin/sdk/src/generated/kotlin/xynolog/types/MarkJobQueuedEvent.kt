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
 * A pending `mark` job, announced with its parameters as it was created.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkJobQueuedEvent(
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("jobType")
    @EncodeDefault
    public val jobType: MarkJobQueuedEventJobType = MarkJobQueuedEventJobType.Mark,
    /**
     * The resource the job is about.
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * The DID of the principal whose `job:create` created the job.
     */
    @SerialName("userId")
    @get:JvmExposeBoxed
    public val userId: UserId,
    @SerialName("params")
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
