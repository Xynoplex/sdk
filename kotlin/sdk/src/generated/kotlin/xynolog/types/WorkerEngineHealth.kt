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
 * One engine at one knowledge base: which it is, the jobs it claims, and what its claims can say of themselves (WORKER-CONTRACT V1).
 */
@Serializable
public data class WorkerEngineHealth(
    @SerialName("engine")
    public val engine: Engine,
    /**
     * The jobs it claims, as its claims state them.
     */
    @SerialName("jobs")
    public val jobs: kotlin.collections.List<JobFilter>,
    /**
     * When a `job:queued` last reached it, or null.
     */
    @SerialName("lastQueuedEventAt")
    public val lastQueuedEventAt: String?,
    /**
     * When it was last handed a job, or null. A claim answered with none pending is not one.
     */
    @SerialName("lastClaimAt")
    public val lastClaimAt: String?,
    /**
     * When a job it held last settled, or null.
     */
    @SerialName("lastFinishedAt")
    public val lastFinishedAt: String?,
    /**
     * When it was last active, or null.
     */
    @SerialName("lastActivityAt")
    public val lastActivityAt: String?,
    /**
     * The job it holds, or null.
     */
    @SerialName("activeJob")
    public val activeJob: WorkerEngineHealthActiveJob?,
    /**
     * How many jobs it has completed since the service started.
     */
    @SerialName("jobsCompleted")
    public val jobsCompleted: Long,
) {
    /** How Java makes a `WorkerEngineHealth`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
        private val jobs: kotlin.collections.List<JobFilter>,
        private val lastQueuedEventAt: String?,
        private val lastClaimAt: String?,
        private val lastFinishedAt: String?,
        private val lastActivityAt: String?,
        private val activeJob: WorkerEngineHealthActiveJob?,
        private val jobsCompleted: Long,
    ) {
        public fun build(): WorkerEngineHealth = WorkerEngineHealth(engine = engine, jobs = jobs, lastQueuedEventAt = lastQueuedEventAt, lastClaimAt = lastClaimAt, lastFinishedAt = lastFinishedAt, lastActivityAt = lastActivityAt, activeJob = activeJob, jobsCompleted = jobsCompleted)
    }

    public companion object {
        /** A builder of a `WorkerEngineHealth` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine, jobs: kotlin.collections.List<JobFilter>, lastQueuedEventAt: String?, lastClaimAt: String?, lastFinishedAt: String?, lastActivityAt: String?, activeJob: WorkerEngineHealthActiveJob?, jobsCompleted: Long): Builder = Builder(engine, jobs, lastQueuedEventAt, lastClaimAt, lastFinishedAt, lastActivityAt, activeJob, jobsCompleted)
    }
}
