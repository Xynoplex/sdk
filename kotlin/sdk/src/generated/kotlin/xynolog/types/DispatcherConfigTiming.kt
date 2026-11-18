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
 * The queue's clocks, in milliseconds. The launcher writes the values a deployment runs with; a test harness shrinks them.
 */
@Serializable
public data class DispatcherConfigTiming(
    /**
     * How often the queue re-announces pending jobs and sweeps for dead workers. The re-announcement is insurance against a lost wake-up, not dispatch.
     */
    @SerialName("tickMs")
    public val tickMs: Long,
    /**
     * How long a running job may go without progress, a checkpoint or a claim before its worker is presumed dead.
     */
    @SerialName("staleRunningMs")
    public val staleRunningMs: Long,
    /**
     * How long the broker waits, after this dispatcher stops renewing a job's lease, before redelivering its message.
     */
    @SerialName("ackWaitMs")
    public val ackWaitMs: Long,
    /**
     * How long a concluded job is kept before it is deleted.
     */
    @SerialName("retentionMs")
    public val retentionMs: Long,
    /**
     * How often concluded jobs past `retentionMs` are deleted.
     */
    @SerialName("retentionSweepMs")
    public val retentionSweepMs: Long,
    /**
     * The least time between two progress writes for one job; reports closer together than this are not written.
     */
    @SerialName("progressWriteIntervalMs")
    public val progressWriteIntervalMs: Long,
    /**
     * How long the dispatcher waits at boot for the broker before it exits, so that a restart policy can retry.
     */
    @SerialName("bootDeadlineMs")
    public val bootDeadlineMs: Long,
) {
    /** How Java makes a `DispatcherConfigTiming`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val tickMs: Long,
        private val staleRunningMs: Long,
        private val ackWaitMs: Long,
        private val retentionMs: Long,
        private val retentionSweepMs: Long,
        private val progressWriteIntervalMs: Long,
        private val bootDeadlineMs: Long,
    ) {
        public fun build(): DispatcherConfigTiming = DispatcherConfigTiming(tickMs = tickMs, staleRunningMs = staleRunningMs, ackWaitMs = ackWaitMs, retentionMs = retentionMs, retentionSweepMs = retentionSweepMs, progressWriteIntervalMs = progressWriteIntervalMs, bootDeadlineMs = bootDeadlineMs)
    }

    public companion object {
        /** A builder of a `DispatcherConfigTiming` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(tickMs: Long, staleRunningMs: Long, ackWaitMs: Long, retentionMs: Long, retentionSweepMs: Long, progressWriteIntervalMs: Long, bootDeadlineMs: Long): Builder = Builder(tickMs, staleRunningMs, ackWaitMs, retentionMs, retentionSweepMs, progressWriteIntervalMs, bootDeadlineMs)
    }
}
