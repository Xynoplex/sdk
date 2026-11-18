// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.JobId
import xynolog.identifiers.UserId

/** What the dispatcher records about a job beside its parameters. `completedUnits` and `unitCursors` appear once a worker has checkpointed. `retryCount` counts the times the queue has put the job back to pending after a failure it classes as transient. */
@Serializable
public data class JobMetadata(
    /** The job's id: `job-` followed by a version 4 UUID written as 32 lowercase hex digits, without dashes. */
    @get:JvmExposeBoxed
    public val id: JobId,
    public val type: JobType,
    /** The DID of the principal whose `job:create` created the job. */
    @get:JvmExposeBoxed
    public val userId: UserId,
    /** When the job was created, as an ISO 8601 timestamp. */
    public val created: String,
    public val retryCount: Long,
    /** How many transient failures the queue retries: 0 for generation, whose re-run produces different content; 1 for every other type. */
    public val maxRetries: Long,
    /** The units a worker has finished, merged across checkpoints and failures as a set. */
    public val completedUnits: kotlin.collections.List<String>? = null,
    /** The furthest each unit begun got, keyed by unit, with what it had counted there. A finished unit keeps its cursor: where it ended, and its final counts. */
    public val unitCursors: kotlin.collections.Map<String, UnitCursor>? = null,
) {
    /** How Java makes a `JobMetadata`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: JobId,
        private val type: JobType,
        private val userId: UserId,
        private val created: String,
        private val retryCount: Long,
        private val maxRetries: Long,
    ) {
        private var completedUnits: kotlin.collections.List<String>? = null
        private var unitCursors: kotlin.collections.Map<String, UnitCursor>? = null

        public fun completedUnits(completedUnits: kotlin.collections.List<String>?): Builder = apply { this.completedUnits = completedUnits }
        public fun unitCursors(unitCursors: kotlin.collections.Map<String, UnitCursor>?): Builder = apply { this.unitCursors = unitCursors }

        public fun build(): JobMetadata = JobMetadata(id = id, type = type, userId = userId, created = created, retryCount = retryCount, maxRetries = maxRetries, completedUnits = completedUnits, unitCursors = unitCursors)
    }

    public companion object {
        /** A builder of a `JobMetadata` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: JobId, type: JobType, userId: UserId, created: String, retryCount: Long, maxRetries: Long): Builder = Builder(id, type, userId, created, retryCount, maxRetries)
    }
}
