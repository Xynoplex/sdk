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
 * A `mark` job's worker says the job is complete, with what a `mark` job reports.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkJobCompleteCommand(
    /**
     * Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this.
     */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @SerialName("jobType")
    @EncodeDefault
    public val jobType: MarkJobCompleteCommandJobType = MarkJobCompleteCommandJobType.Mark,
    /**
     * Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows.
     */
    @SerialName("attempt")
    public val attempt: Long? = null,
    @SerialName("result")
    public val result: MarkJobResult? = null,
    @SerialName("durability")
    public val durability: DurabilityEvidence? = null,
) : JobCompleteCommand {
    /** How Java makes a `MarkJobCompleteCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val jobId: JobId,
    ) {
        private var userId: UserId? = null
        private var attempt: Long? = null
        private var result: MarkJobResult? = null
        private var durability: DurabilityEvidence? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun attempt(attempt: Long?): Builder {
            this.attempt = attempt
            return this
        }

        public fun result(result: MarkJobResult?): Builder {
            this.result = result
            return this
        }

        public fun durability(durability: DurabilityEvidence?): Builder {
            this.durability = durability
            return this
        }

        public fun build(): MarkJobCompleteCommand = MarkJobCompleteCommand(userId = userId, resourceId = resourceId, jobId = jobId, attempt = attempt, result = result, durability = durability)
    }

    public companion object {
        /** A builder of a `MarkJobCompleteCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId): Builder = Builder(resourceId, jobId)
    }
}
