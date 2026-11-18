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
 * One engine a worker runs: which it is, the jobs the worker claims to do with it, and where its provider is reached.
 */
@Serializable
public data class WorkerEngineConfig(
    @SerialName("engine")
    public val engine: Engine,
    /**
     * The jobs the worker claims to do with this engine, as a claim names them (`job:claim`'s `accepts`): it claims with these filters and no other.
     */
    @SerialName("jobs")
    public val jobs: kotlin.collections.List<JobFilter>,
    /**
     * The address the provider's API is reached at.
     */
    @SerialName("baseUrl")
    public val baseUrl: String,
    /**
     * The environment variable holding the provider's API key, when the provider requires one.
     */
    @SerialName("apiKeyEnv")
    public val apiKeyEnv: String? = null,
) {
    /** How Java makes a `WorkerEngineConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
        private val jobs: kotlin.collections.List<JobFilter>,
        private val baseUrl: String,
    ) {
        private var apiKeyEnv: String? = null

        public fun apiKeyEnv(apiKeyEnv: String?): Builder {
            this.apiKeyEnv = apiKeyEnv
            return this
        }

        public fun build(): WorkerEngineConfig = WorkerEngineConfig(engine = engine, jobs = jobs, baseUrl = baseUrl, apiKeyEnv = apiKeyEnv)
    }

    public companion object {
        /** A builder of a `WorkerEngineConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine, jobs: kotlin.collections.List<JobFilter>, baseUrl: String): Builder = Builder(engine, jobs, baseUrl)
    }
}
