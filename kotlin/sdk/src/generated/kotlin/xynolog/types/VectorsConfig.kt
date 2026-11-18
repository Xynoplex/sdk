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

/** The vector index a service writes or searches, and what that kind of index needs to be reached: one of the kinds `xynolog-vectors` has a store for, told apart by `type`. */
@Serializable(with = VectorsConfigSerializer::class)
public sealed interface VectorsConfig

internal object VectorsConfigSerializer : JsonContentPolymorphicSerializer<VectorsConfig>(VectorsConfig::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.VectorsConfig", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<VectorsConfig> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "qdrant" -> QdrantVectorsConfig.serializer()
            "memory" -> MemoryVectorsConfig.serializer()
            else -> throw SerializationException("a VectorsConfig states a `type` that is one of `qdrant`, `memory`")
        }
}
