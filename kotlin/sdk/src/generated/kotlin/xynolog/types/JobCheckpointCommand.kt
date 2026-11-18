// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId
import xynolog.identifiers.UserId

/** Command to persist a running job's completed-unit checkpoint AT unit completion. Distinct from JobFailCommand's checkpoint, which lands only on a clean failure: a worker that dies (crash/OOM/kill) never emits job:fail, so this durable, unthrottled write is what lets the janitor's stale-running recovery resume a dead worker's job rather than redo its finished units. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCheckpointCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    /** Entity-type units whose annotations have been fully emitted so far. Unioned into the running job's metadata checkpoint; a retry after recovery skips them. */
    public val completedUnits: kotlin.collections.List<String>,
    /** The furthest each unit begun got, keyed by unit, with what it had counted there — the grain `completedUnits` cannot express. A unit named in `completedUnits` is stated here too, by the cursor it ended at: a later attempt skips it whole and counts it by that cursor. A cursor never says a unit is finished; only `completedUnits` does. Merged monotonically per unit, finished or not: a stale snapshot must never move a cursor backward. */
    public val unitCursors: kotlin.collections.Map<String, UnitCursor>? = null,
) {
    /** How Java makes a `JobCheckpointCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val jobId: JobId,
        private val completedUnits: kotlin.collections.List<String>,
    ) {
        private var userId: UserId? = null
        private var unitCursors: kotlin.collections.Map<String, UnitCursor>? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun unitCursors(unitCursors: kotlin.collections.Map<String, UnitCursor>?): Builder = apply { this.unitCursors = unitCursors }

        public fun build(): JobCheckpointCommand = JobCheckpointCommand(userId = userId, jobId = jobId, completedUnits = completedUnits, unitCursors = unitCursors)
    }

    public companion object {
        /** A builder of a `JobCheckpointCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(jobId: JobId, completedUnits: kotlin.collections.List<String>): Builder = Builder(jobId, completedUnits)
    }
}
