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

@Serializable
@JsonIgnoreUnknownKeys
public data class JobStatusResponse(
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("type")
    public val type: JobType,
    @SerialName("status")
    public val status: JobStatusResponseStatus,
    @SerialName("userId")
    @get:JvmExposeBoxed
    public val userId: UserId,
    @SerialName("created")
    public val created: String,
    @SerialName("startedAt")
    public val startedAt: String? = null,
    @SerialName("completedAt")
    public val completedAt: String? = null,
    @SerialName("error")
    public val error: String? = null,
    @SerialName("failureClass")
    public val failureClass: FailureClass? = null,
    @SerialName("progress")
    public val progress: JobStoredProgress? = null,
    @SerialName("result")
    public val result: JobStoredResult? = null,
) {
    /** How Java makes a `JobStatusResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val type: JobType,
        private val status: JobStatusResponseStatus,
        private val userId: UserId,
        private val created: String,
    ) {
        private var startedAt: String? = null
        private var completedAt: String? = null
        private var error: String? = null
        private var failureClass: FailureClass? = null
        private var progress: JobStoredProgress? = null
        private var result: JobStoredResult? = null

        public fun startedAt(startedAt: String?): Builder {
            this.startedAt = startedAt
            return this
        }

        public fun completedAt(completedAt: String?): Builder {
            this.completedAt = completedAt
            return this
        }

        public fun error(error: String?): Builder {
            this.error = error
            return this
        }

        public fun failureClass(failureClass: FailureClass?): Builder {
            this.failureClass = failureClass
            return this
        }

        public fun progress(progress: JobStoredProgress?): Builder {
            this.progress = progress
            return this
        }

        public fun result(result: JobStoredResult?): Builder {
            this.result = result
            return this
        }

        public fun build(): JobStatusResponse = JobStatusResponse(jobId = jobId, type = type, status = status, userId = userId, created = created, startedAt = startedAt, completedAt = completedAt, error = error, failureClass = failureClass, progress = progress, result = result)
    }

    public companion object {
        /** A builder of a `JobStatusResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, type: JobType, status: JobStatusResponseStatus, userId: UserId, created: String): Builder = Builder(jobId, type, status, userId, created)
    }
}
