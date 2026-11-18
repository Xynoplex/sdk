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
 * An embedding model served by Voyage AI. No service has been run against Voyage itself.
 */
@Serializable
public data class VoyageEmbeddingConfig(
    @SerialName("type")
    @EncodeDefault
    public val type: VoyageEmbeddingConfigType = VoyageEmbeddingConfigType.Voyage,
    /**
     * The model asked for, by Voyage's name for it.
     */
    @SerialName("model")
    public val model: String,
    /**
     * The whole address of Voyage's embeddings call (`https://api.voyageai.com/v1/embeddings`).
     */
    @SerialName("endpoint")
    public val endpoint: String,
    /**
     * The environment variable holding the Voyage API key. The key is never a value here.
     */
    @SerialName("apiKeyEnv")
    public val apiKeyEnv: String,
) : EmbeddingConfig {
    /** How Java makes a `VoyageEmbeddingConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val model: String,
        private val endpoint: String,
        private val apiKeyEnv: String,
    ) {
        public fun build(): VoyageEmbeddingConfig = VoyageEmbeddingConfig(model = model, endpoint = endpoint, apiKeyEnv = apiKeyEnv)
    }

    public companion object {
        /** A builder of a `VoyageEmbeddingConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(model: String, endpoint: String, apiKeyEnv: String): Builder = Builder(model, endpoint, apiKeyEnv)
    }
}
