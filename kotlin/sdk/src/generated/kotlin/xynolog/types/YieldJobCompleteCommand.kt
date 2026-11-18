// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** A `yield` job's worker says the job is complete, with what a `yield` job reports. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldJobCompleteCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @EncodeDefault
    public val jobType: YieldJobCompleteCommandJobType = YieldJobCompleteCommandJobType.Yield,
    /** Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows. */
    public val attempt: Long? = null,
    /** The annotation the job's context was focused on, when it was focused on one. Lets a client route the completion to that annotation. */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    public val result: YieldJobResult? = null,
    public val durability: DurabilityEvidence? = null,
) : JobCompleteCommand {
    /** How Java makes a `YieldJobCompleteCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val jobId: JobId,
    ) {
        private var userId: UserId? = null
        private var attempt: Long? = null
        private var annotationId: AnnotationId? = null
        private var result: YieldJobResult? = null
        private var durability: DurabilityEvidence? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun result(result: YieldJobResult?): Builder = apply { this.result = result }
        public fun durability(durability: DurabilityEvidence?): Builder = apply { this.durability = durability }

        public fun build(): YieldJobCompleteCommand = YieldJobCompleteCommand(userId = userId, resourceId = resourceId, jobId = jobId, attempt = attempt, annotationId = annotationId, result = result, durability = durability)
    }

    public companion object {
        /** A builder of a `YieldJobCompleteCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId): Builder = Builder(resourceId, jobId)
    }
}
