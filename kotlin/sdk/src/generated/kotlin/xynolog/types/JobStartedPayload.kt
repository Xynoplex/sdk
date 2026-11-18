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
 * Payload for job:started domain event
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobStartedPayload(
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("jobType")
    public val jobType: JobType,
    /**
     * Annotation this job is attached to, when applicable
     */
    @SerialName("annotationId")
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    @SerialName("totalSteps")
    public val totalSteps: Long? = null,
) {
    /** How Java makes a `JobStartedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
    ) {
        private var annotationId: AnnotationId? = null
        private var totalSteps: Long? = null

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder {
            this.annotationId = annotationId
            return this
        }

        public fun totalSteps(totalSteps: Long?): Builder {
            this.totalSteps = totalSteps
            return this
        }

        public fun build(): JobStartedPayload = JobStartedPayload(jobId = jobId, jobType = jobType, annotationId = annotationId, totalSteps = totalSteps)
    }

    public companion object {
        /** A builder of a `JobStartedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType): Builder = Builder(jobId, jobType)
    }
}
