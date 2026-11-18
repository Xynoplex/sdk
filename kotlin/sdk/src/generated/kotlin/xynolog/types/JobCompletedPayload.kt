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
 * Payload for job:completed domain event
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCompletedPayload(
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
    @SerialName("totalSteps")
    public val totalSteps: Long? = null,
    /**
     * For detection: total entities found
     */
    @SerialName("foundCount")
    public val foundCount: Long? = null,
    /**
     * For generation: ID of generated resource
     */
    @SerialName("resultResourceId")
    @get:JvmExposeBoxed
    public val resultResourceId: ResourceId? = null,
    /**
     * For generation: URI of annotation that triggered generation
     */
    @SerialName("annotationUri")
    public val annotationUri: String? = null,
    /**
     * Full result object for extensibility
     */
    @SerialName("result")
    public val result: JsonObject? = null,
    @SerialName("durability")
    public val durability: DurabilityEvidence? = null,
) {
    /** How Java makes a `JobCompletedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val jobType: JobType,
    ) {
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var totalSteps: Long? = null
        private var foundCount: Long? = null
        private var resultResourceId: ResourceId? = null
        private var annotationUri: String? = null
        private var result: JsonObject? = null
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

        public fun totalSteps(totalSteps: Long?): Builder {
            this.totalSteps = totalSteps
            return this
        }

        public fun foundCount(foundCount: Long?): Builder {
            this.foundCount = foundCount
            return this
        }

        @JvmExposeBoxed
        public fun resultResourceId(resultResourceId: ResourceId?): Builder {
            this.resultResourceId = resultResourceId
            return this
        }

        public fun annotationUri(annotationUri: String?): Builder {
            this.annotationUri = annotationUri
            return this
        }

        public fun result(result: JsonObject?): Builder {
            this.result = result
            return this
        }

        public fun durability(durability: DurabilityEvidence?): Builder {
            this.durability = durability
            return this
        }

        public fun build(): JobCompletedPayload = JobCompletedPayload(jobId = jobId, jobType = jobType, attempt = attempt, annotationId = annotationId, totalSteps = totalSteps, foundCount = foundCount, resultResourceId = resultResourceId, annotationUri = annotationUri, result = result, durability = durability)
    }

    public companion object {
        /** A builder of a `JobCompletedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, jobType: JobType): Builder = Builder(jobId, jobType)
    }
}
