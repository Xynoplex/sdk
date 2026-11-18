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
 * Payload for the job:failed domain event — a permanent fact of the resource, not operational state. It carries the judgments the worker COMPUTED, not just its message: at the log they are otherwise unrecoverable, the only remaining witness being a flattened English string.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobFailedPayload(
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("jobType")
    public val jobType: JobType,
    /**
     * Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows.
     */
    @SerialName("attempt")
    public val attempt: Long? = null,
    /**
     * Annotation this job was attached to, when applicable
     */
    @SerialName("annotationId")
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    @SerialName("error")
    public val error: String,
    @SerialName("failureClass")
    public val failureClass: FailureClass? = null,
    /**
     * Whether the worker computed that the queue would re-queue this job (same predicate the queue applies, `willRetryAfter`). Absent means the worker stated nothing. Without it a reader of the log cannot tell a run recovering across several job:failed events from that many dead jobs.
     */
    @SerialName("willRetry")
    public val willRetry: Boolean? = null,
    @SerialName("durability")
    public val durability: DurabilityEvidence? = null,
) {
    /** How Java makes a `JobFailedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
        private val error: String,
    ) {
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var failureClass: FailureClass? = null
        private var willRetry: Boolean? = null
        private var durability: DurabilityEvidence? = null

        public fun attempt(attempt: Long?): Builder {
            this.attempt = attempt
            return this
        }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder {
            this.annotationId = annotationId
            return this
        }

        public fun failureClass(failureClass: FailureClass?): Builder {
            this.failureClass = failureClass
            return this
        }

        public fun willRetry(willRetry: Boolean?): Builder {
            this.willRetry = willRetry
            return this
        }

        public fun durability(durability: DurabilityEvidence?): Builder {
            this.durability = durability
            return this
        }

        public fun build(): JobFailedPayload = JobFailedPayload(jobId = jobId, jobType = jobType, attempt = attempt, annotationId = annotationId, error = error, failureClass = failureClass, willRetry = willRetry, durability = durability)
    }

    public companion object {
        /** A builder of a `JobFailedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType, error: String): Builder = Builder(jobId, jobType, error)
    }
}
