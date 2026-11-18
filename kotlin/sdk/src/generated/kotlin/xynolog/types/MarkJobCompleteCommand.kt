// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** A `mark` job's worker says the job is complete, with what a `mark` job reports. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkJobCompleteCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    @EncodeDefault
    public val jobType: MarkJobCompleteCommandJobType = MarkJobCompleteCommandJobType.Mark,
    /** Which attempt produced this event, 1-based (a first run is 1). ALWAYS present: the queue re-runs a failed job silently, so an operator reading progress or a terminal record has no other way to tell a re-run from a first run — and provider spend, already counted in xynolog_inference_tokens_total, cannot be attributed to a repeated document without it. Stated rather than inferred from absence, because 'attempt 1' is a fact the emitter always knows. */
    public val attempt: Long? = null,
    public val result: MarkJobResult? = null,
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
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun attempt(attempt: Long?): Builder = apply { this.attempt = attempt }
        public fun result(result: MarkJobResult?): Builder = apply { this.result = result }
        public fun durability(durability: DurabilityEvidence?): Builder = apply { this.durability = durability }

        public fun build(): MarkJobCompleteCommand = MarkJobCompleteCommand(userId = userId, resourceId = resourceId, jobId = jobId, attempt = attempt, result = result, durability = durability)
    }

    public companion object {
        /** A builder of a `MarkJobCompleteCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId): Builder = Builder(resourceId, jobId)
    }
}
