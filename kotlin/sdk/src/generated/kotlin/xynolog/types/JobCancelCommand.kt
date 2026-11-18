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
 * A worker's settling of a running job it holds whose work it has stopped for a cancellation — the queue moves the job to cancelled/. Distinct from JobCancelRequest (the client→worker REQUEST to stop): this is the worker announcing it did, so the running job is never yanked to cancelled/ out from under a live worker (the roach-motel race).
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCancelCommand(
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
    public val jobType: JobType,
    /**
     * Annotation this job is attached to, when applicable. Lets the UI route cancellation feedback to a specific annotation.
     */
    @SerialName("annotationId")
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /**
     * The units the worker had finished when it stopped. Recorded on the cancelled job's metadata so the work already done stays visible.
     */
    @SerialName("completedUnits")
    public val completedUnits: kotlin.collections.List<String>? = null,
    /**
     * The furthest each unit begun got, keyed by unit, with what it had counted there — the grain `completedUnits` cannot express. A unit named in `completedUnits` is stated here too, by the cursor it ended at: a later attempt skips it whole and counts it by that cursor. A cursor never says a unit is finished; only `completedUnits` does. Merged monotonically per unit, finished or not: a stale snapshot must never move a cursor backward.
     */
    @SerialName("unitCursors")
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
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder {
            this.annotationId = annotationId
            return this
        }

        public fun completedUnits(completedUnits: kotlin.collections.List<String>?): Builder {
            this.completedUnits = completedUnits
            return this
        }

        public fun unitCursors(unitCursors: kotlin.collections.Map<String, UnitCursor>?): Builder {
            this.unitCursors = unitCursors
            return this
        }

        public fun build(): JobCancelCommand = JobCancelCommand(userId = userId, resourceId = resourceId, jobId = jobId, jobType = jobType, annotationId = annotationId, completedUnits = completedUnits, unitCursors = unitCursors)
    }

    public companion object {
        /** A builder of a `JobCancelCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, jobId: JobId, jobType: JobType): Builder = Builder(resourceId, jobId, jobType)
    }
}
