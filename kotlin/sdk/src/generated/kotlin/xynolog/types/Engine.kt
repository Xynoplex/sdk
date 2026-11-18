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
 * An engine: an inference provider and a model, which software does a job or an actor's step with. An engine is not a principal: the principal that used one names it on each write it produced with it (`generator`). A person who does a job uses none.
 */
@Serializable
public data class Engine(
    /**
     * The inference provider: who serves the model. `anthropic`, `google`, `openai` and `together` are those companies' own APIs. `llamacpp`, `ollama` and `vllm` are servers a deployment runs or reaches, each named for the server's software.
     */
    @SerialName("provider")
    public val provider: EngineProvider,
    /**
     * The model identifier, as the provider names it.
     */
    @SerialName("model")
    public val model: String,
) {
    /** How Java makes a `Engine`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val provider: EngineProvider,
        private val model: String,
    ) {
        public fun build(): Engine = Engine(provider = provider, model = model)
    }

    public companion object {
        /** A builder of a `Engine` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(provider: EngineProvider, model: String): Builder = Builder(provider, model)
    }
}
