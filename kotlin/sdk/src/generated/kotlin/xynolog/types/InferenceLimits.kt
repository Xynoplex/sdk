// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A provider's actual ceilings for a model, discovered from the provider itself (Anthropic Models API; Ollama /api/show) — never hand-maintained constants. Semantics differ by provider shape: Anthropic reports maximum input tokens in contextTokens with a separate output ceiling in maxOutputTokens; Ollama reports the shared input+output window and mirrors it into both fields (there is no separate output ceiling), so maxOutputTokens === contextTokens signals a shared window. */
@Serializable
@JsonIgnoreUnknownKeys
public data class InferenceLimits(
    /** The context window in tokens. Anthropic: maximum input tokens (output has its own ceiling). Ollama: the shared input+output window. */
    public val contextTokens: Double,
    /** Maximum output tokens per generation. Equal to contextTokens when the provider has a single shared window. */
    public val maxOutputTokens: Double,
    /** Whether this engine accepts a caller-supplied sampling temperature, measured against the provider (Anthropic: an active probe at discovery, because some models reject the parameter outright and the Models API does not say; Ollama: always true). Consumers treat only an explicit false as 'hide temperature controls' — absence means no claim. */
    public val acceptsTemperature: Boolean? = null,
) {
    /** How Java makes a `InferenceLimits`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val contextTokens: Double,
        private val maxOutputTokens: Double,
    ) {
        private var acceptsTemperature: Boolean? = null

        public fun acceptsTemperature(acceptsTemperature: Boolean?): Builder = apply { this.acceptsTemperature = acceptsTemperature }

        public fun build(): InferenceLimits = InferenceLimits(contextTokens = contextTokens, maxOutputTokens = maxOutputTokens, acceptsTemperature = acceptsTemperature)
    }

    public companion object {
        /** A builder of a `InferenceLimits` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(contextTokens: Double, maxOutputTokens: Double): Builder = Builder(contextTokens, maxOutputTokens)
    }
}
