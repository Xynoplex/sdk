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
 * One knowledge base the worker serves, as its health says it. `did` and `engines` are there while it is `working`, and only then.
 */
@Serializable
public data class WorkerKnowledgeBaseHealth(
    /**
     * The entry's `domain`.
     */
    @SerialName("domain")
    public val domain: String,
    /**
     * `starting`: signing in, opening its stream, confirming it, or waiting to start again. `working`: confirmed, its engines claiming. `refused`: refused, until the service is started again.
     */
    @SerialName("state")
    public val state: WorkerKnowledgeBaseHealthState,
    /**
     * The agent's DID at this knowledge base, as its gateway named it.
     */
    @SerialName("did")
    public val did: String? = null,
    /**
     * One entry for each of the entry's engines, in its order.
     */
    @SerialName("engines")
    public val engines: kotlin.collections.List<WorkerEngineHealth>? = null,
) {
    /** How Java makes a `WorkerKnowledgeBaseHealth`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val domain: String,
        private val state: WorkerKnowledgeBaseHealthState,
    ) {
        private var did: String? = null
        private var engines: kotlin.collections.List<WorkerEngineHealth>? = null

        public fun did(did: String?): Builder {
            this.did = did
            return this
        }

        public fun engines(engines: kotlin.collections.List<WorkerEngineHealth>?): Builder {
            this.engines = engines
            return this
        }

        public fun build(): WorkerKnowledgeBaseHealth = WorkerKnowledgeBaseHealth(domain = domain, state = state, did = did, engines = engines)
    }

    public companion object {
        /** A builder of a `WorkerKnowledgeBaseHealth` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(domain: String, state: WorkerKnowledgeBaseHealthState): Builder = Builder(domain, state)
    }
}
