// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** An embedding model served by an Ollama. */
@Serializable
public data class OllamaEmbeddingConfig(
    @EncodeDefault
    public val type: OllamaEmbeddingConfigType = OllamaEmbeddingConfigType.Ollama,
    /** The model asked for, by the name the Ollama serves it under. */
    public val model: String,
    /** The address the Ollama's API is reached at (`http://host:11434`). */
    public val baseUrl: String,
) : EmbeddingConfig {
    /** How Java makes a `OllamaEmbeddingConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val model: String,
        private val baseUrl: String,
    ) {
        public fun build(): OllamaEmbeddingConfig = OllamaEmbeddingConfig(model = model, baseUrl = baseUrl)
    }

    public companion object {
        /** A builder of a `OllamaEmbeddingConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(model: String, baseUrl: String): Builder = Builder(model, baseUrl)
    }
}
