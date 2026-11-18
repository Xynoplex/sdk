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
 * Everything the gateway reads at boot: nothing in it is defaulted by the gateway. The launcher writes it for the gateway it starts — from the knowledge base's committed identity and its stack documents — and a gateway started any other way is given the same document at the path its `--config` flag names (the image passes `/etc/xynolog/gateway.json`). Started without `--config`, or with a path that names no file, the gateway refuses to start and says which. Secrets are never values here: a field that needs one names the environment variable holding it. The gateway's other inputs are the environment variables specs/src/service-environment/variables.json lists for it, and the ones this document names. A document that does not validate is refused at boot — the gateway exits without serving — and the refusal names each failing field by its JSON pointer.
 */
@Serializable
public data class GatewayConfig(
    @SerialName("kb")
    public val kb: KbIdentity,
    /**
     * The port the gateway listens on, on every address the host has: IPv4 and IPv6.
     */
    @SerialName("port")
    public val port: Long,
    /**
     * The URL clients reach this gateway at: the `servers` entry of the OpenAPI document it serves.
     */
    @SerialName("publicUrl")
    public val publicUrl: String,
    /**
     * The issuer this knowledge base trusts.
     */
    @SerialName("identity")
    public val identity: GatewayConfigIdentity,
    /**
     * Where the Archivist listens.
     */
    @SerialName("archivist")
    public val archivist: GatewayConfigArchivist,
    /**
     * The signal plane: `in-process`, one gateway on its own fabric; or `nats`, the fabric every replica on one broker shares, which requires `servers` and a broker with JetStream.
     */
    @SerialName("signal")
    public val signal: GatewayConfigSignal,
    @SerialName("logLevel")
    public val logLevel: LogLevel,
    @SerialName("logFormat")
    public val logFormat: LogFormat,
    /**
     * What this gateway process can hold, from the memory its deployment gives it. `queuedBytes`: the bytes queued for all its streams together; at it, a new stream is refused with 503 (`AtCapacity`, code `capacity`) until the queues drain — each stream's own bound is `x-xynolog-limits.pendingWriteBytes`. `connections`: the connections it holds open at once; one past it is closed unanswered. The launcher derives both from the memory it gives the gateway's container.
     */
    @SerialName("capacity")
    public val capacity: GatewayConfigCapacity,
) {
    /** How Java makes a `GatewayConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kb: KbIdentity,
        private val port: Long,
        private val publicUrl: String,
        private val identity: GatewayConfigIdentity,
        private val archivist: GatewayConfigArchivist,
        private val signal: GatewayConfigSignal,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
        private val capacity: GatewayConfigCapacity,
    ) {
        public fun build(): GatewayConfig = GatewayConfig(kb = kb, port = port, publicUrl = publicUrl, identity = identity, archivist = archivist, signal = signal, logLevel = logLevel, logFormat = logFormat, capacity = capacity)
    }

    public companion object {
        /** A builder of a `GatewayConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kb: KbIdentity, port: Long, publicUrl: String, identity: GatewayConfigIdentity, archivist: GatewayConfigArchivist, signal: GatewayConfigSignal, logLevel: LogLevel, logFormat: LogFormat, capacity: GatewayConfigCapacity): Builder = Builder(kb, port, publicUrl, identity, archivist, signal, logLevel, logFormat, capacity)
    }
}
