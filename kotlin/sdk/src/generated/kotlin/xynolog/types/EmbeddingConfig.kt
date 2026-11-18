// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/** The embedding provider a service asks for vectors, and what that kind of provider needs to be asked: one of the providers `xynolog-vectors` has, told apart by `type`. Two services that share an index name the same provider and the same model: a vector is compared only with vectors of the model that made it. A secret is never a value here: a provider's key is named by the environment variable that holds it. */
@Serializable(with = EmbeddingConfigSerializer::class)
public sealed interface EmbeddingConfig

internal object EmbeddingConfigSerializer : JsonContentPolymorphicSerializer<EmbeddingConfig>(EmbeddingConfig::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.EmbeddingConfig", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<EmbeddingConfig> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "ollama" -> OllamaEmbeddingConfig.serializer()
            "voyage" -> VoyageEmbeddingConfig.serializer()
            else -> throw SerializationException("a EmbeddingConfig states a `type` that is one of `ollama`, `voyage`")
        }
}
