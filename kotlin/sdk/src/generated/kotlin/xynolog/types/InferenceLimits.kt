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
 * A provider's actual ceilings for a model, discovered from the provider itself (Anthropic Models API; Ollama /api/show) — never hand-maintained constants. Semantics differ by provider shape: Anthropic reports maximum input tokens in contextTokens with a separate output ceiling in maxOutputTokens; Ollama reports the shared input+output window and mirrors it into both fields (there is no separate output ceiling), so maxOutputTokens === contextTokens signals a shared window.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class InferenceLimits(
    /**
     * The context window in tokens. Anthropic: maximum input tokens (output has its own ceiling). Ollama: the shared input+output window.
     */
    @SerialName("contextTokens")
    public val contextTokens: Double,
    /**
     * Maximum output tokens per generation. Equal to contextTokens when the provider has a single shared window.
     */
    @SerialName("maxOutputTokens")
    public val maxOutputTokens: Double,
    /**
     * Whether this engine accepts a caller-supplied sampling temperature, measured against the provider (Anthropic: an active probe at discovery, because some models reject the parameter outright and the Models API does not say; Ollama: always true). Consumers treat only an explicit false as 'hide temperature controls' — absence means no claim.
     */
    @SerialName("acceptsTemperature")
    public val acceptsTemperature: Boolean? = null,
) {
    /** How Java makes a `InferenceLimits`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val contextTokens: Double,
        private val maxOutputTokens: Double,
    ) {
        private var acceptsTemperature: Boolean? = null

        public fun acceptsTemperature(acceptsTemperature: Boolean?): Builder {
            this.acceptsTemperature = acceptsTemperature
            return this
        }

        public fun build(): InferenceLimits = InferenceLimits(contextTokens = contextTokens, maxOutputTokens = maxOutputTokens, acceptsTemperature = acceptsTemperature)
    }

    public companion object {
        /** A builder of a `InferenceLimits` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(contextTokens: Double, maxOutputTokens: Double): Builder = Builder(contextTokens, maxOutputTokens)
    }
}
