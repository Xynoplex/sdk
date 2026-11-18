// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** A worker's settling of a running job it holds whose work it has stopped for a cancellation — the queue moves the job to cancelled/. Distinct from JobCancelRequest (the client→worker REQUEST to stop): this is the worker announcing it did, so the running job is never yanked to cancelled/ out from under a live worker (the roach-motel race). */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCancelCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val jobId: JobId,
    public val jobType: JobType,
    /** Annotation this job is attached to, when applicable. Lets the UI route cancellation feedback to a specific annotation. */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /** The units the worker had finished when it stopped. Recorded on the cancelled job's metadata so the work already done stays visible. */
    public val completedUnits: kotlin.collections.List<String>? = null,
    /** The furthest each unit begun got, keyed by unit, with what it had counted there — the grain `completedUnits` cannot express. A unit named in `completedUnits` is stated here too, by the cursor it ended at: a later attempt skips it whole and counts it by that cursor. A cursor never says a unit is finished; only `completedUnits` does. Merged monotonically per unit, finished or not: a stale snapshot must never move a cursor backward. */
    public val unitCursors: kotlin.collections.Map<String, UnitCursor>? = null,
) {
    /** How Java makes a `JobCancelCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val jobId: JobId,
        private val jobType: JobType,
    ) {
        private var userId: UserId? = null
        private var annotationId: AnnotationId? = null
        private var completedUnits: kotlin.collections.List<String>? = null
        private var unitCursors: kotlin.collections.Map<String, UnitCursor>? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun completedUnits(completedUnits: kotlin.collections.List<String>?): Builder = apply { this.completedUnits = completedUnits }
        public fun unitCursors(unitCursors: kotlin.collections.Map<String, UnitCursor>?): Builder = apply { this.unitCursors = unitCursors }

        public fun build(): JobCancelCommand = JobCancelCommand(userId = userId, resourceId = resourceId, jobId = jobId, jobType = jobType, annotationId = annotationId, completedUnits = completedUnits, unitCursors = unitCursors)
    }

    public companion object {
        /** A builder of a `JobCancelCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId, jobType: JobType): Builder = Builder(resourceId, jobId, jobType)
    }
}
