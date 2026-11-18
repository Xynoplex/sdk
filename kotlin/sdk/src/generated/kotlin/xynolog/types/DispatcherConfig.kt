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
 * Everything the dispatcher reads at boot: nothing in it is defaulted by the dispatcher. The launcher writes it for the dispatcher it starts, from the knowledge base's stack documents, and the dispatcher reads it from the path its `--config` flag names (its image passes `/etc/xynolog/dispatcher.json`). Started without `--config`, or with a path that names no file, the dispatcher refuses to start and says which. Secrets are never values here: a field that needs one names the environment variable holding it. The dispatcher's other inputs are the environment variables specs/src/service-environment/variables.json lists for it, and the ones this document names. A document that does not validate is refused at boot, naming each failing field.
 */
@Serializable
public data class DispatcherConfig(
    @SerialName("kb")
    public val kb: KbIdentity,
    /**
     * The URL the dispatcher reaches the gateway at: its only route to the bus.
     */
    @SerialName("gatewayUrl")
    public val gatewayUrl: String,
    /**
     * The issuer the dispatcher's service account signs in at.
     */
    @SerialName("identity")
    public val identity: ServiceIdentity,
    /**
     * The JetStream broker holding the job queue, whose layout is specs/src/jobs/storage.json.
     */
    @SerialName("queue")
    public val queue: DispatcherConfigQueue,
    /**
     * The port the dispatcher answers `/health` on.
     */
    @SerialName("port")
    public val port: Long,
    /**
     * The queue's clocks, in milliseconds. The launcher writes the values a deployment runs with; a test harness shrinks them.
     */
    @SerialName("timing")
    public val timing: DispatcherConfigTiming,
    @SerialName("logLevel")
    public val logLevel: LogLevel,
    @SerialName("logFormat")
    public val logFormat: LogFormat,
) {
    /** How Java makes a `DispatcherConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KbIdentity,
        private val gatewayUrl: String,
        private val identity: ServiceIdentity,
        private val queue: DispatcherConfigQueue,
        private val port: Long,
        private val timing: DispatcherConfigTiming,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): DispatcherConfig = DispatcherConfig(kb = kb, gatewayUrl = gatewayUrl, identity = identity, queue = queue, port = port, timing = timing, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `DispatcherConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KbIdentity, gatewayUrl: String, identity: ServiceIdentity, queue: DispatcherConfigQueue, port: Long, timing: DispatcherConfigTiming, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(kb, gatewayUrl, identity, queue, port, timing, logLevel, logFormat)
    }
}
