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
 * One knowledge base a worker does jobs for: which it is, where its gateway is, the account the worker signs in as there, and the engines it offers it. The worker signs in, confirms the knowledge base and claims at each knowledge base apart from every other.
 */
@Serializable
public data class WorkerKnowledgeBaseConfig(
    /**
     * The knowledge base's did:web domain, as it answers `browse:kb-requested`: which knowledge base this is. The worker confirms it there before it claims, and refuses a knowledge base that answers another domain, or none.
     */
    @SerialName("domain")
    public val domain: String,
    /**
     * The URL the worker reaches the knowledge base's gateway at: its route to the bus and to a resource's bytes, and the only address of the knowledge base it holds.
     */
    @SerialName("gatewayUrl")
    public val gatewayUrl: String,
    /**
     * Where the worker signs in for this knowledge base, and as which client.
     */
    @SerialName("identity")
    public val identity: WorkerKnowledgeBaseConfigIdentity,
    /**
     * The engines the worker offers this knowledge base, and the jobs it does with each: its own choice, on its own providers' keys. It claims each engine's jobs there for it, so a job no engine here is used for is not claimed at this knowledge base.
     */
    @SerialName("engines")
    public val engines: kotlin.collections.List<WorkerEngineConfig>,
) {
    /** How Java makes a `WorkerKnowledgeBaseConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val domain: String,
        private val gatewayUrl: String,
        private val identity: WorkerKnowledgeBaseConfigIdentity,
        private val engines: kotlin.collections.List<WorkerEngineConfig>,
    ) {
        public fun build(): WorkerKnowledgeBaseConfig = WorkerKnowledgeBaseConfig(domain = domain, gatewayUrl = gatewayUrl, identity = identity, engines = engines)
    }

    public companion object {
        /** A builder of a `WorkerKnowledgeBaseConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(domain: String, gatewayUrl: String, identity: WorkerKnowledgeBaseConfigIdentity, engines: kotlin.collections.List<WorkerEngineConfig>): Builder = Builder(domain, gatewayUrl, identity, engines)
    }
}
