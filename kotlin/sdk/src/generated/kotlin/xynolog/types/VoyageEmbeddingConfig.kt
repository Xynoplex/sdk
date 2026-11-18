// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** An embedding model served by Voyage AI. No service has been run against Voyage itself. */
@Serializable
public data class VoyageEmbeddingConfig(
    @EncodeDefault
    public val type: VoyageEmbeddingConfigType = VoyageEmbeddingConfigType.Voyage,
    /** The model asked for, by Voyage's name for it. */
    public val model: String,
    /** The whole address of Voyage's embeddings call (`https://api.voyageai.com/v1/embeddings`). */
    public val endpoint: String,
    /** The environment variable holding the Voyage API key. The key is never a value here. */
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
