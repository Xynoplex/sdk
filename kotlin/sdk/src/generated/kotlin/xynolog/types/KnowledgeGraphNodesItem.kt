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

@Serializable(with = KnowledgeGraphNodesItemSerializer::class)
public sealed interface KnowledgeGraphNodesItem

internal object KnowledgeGraphNodesItemSerializer : JsonContentPolymorphicSerializer<KnowledgeGraphNodesItem>(KnowledgeGraphNodesItem::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.KnowledgeGraphNodesItem", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<KnowledgeGraphNodesItem> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "resource" -> GraphResourceNode.serializer()
            "annotation" -> GraphAnnotationNode.serializer()
            else -> throw SerializationException("a KnowledgeGraphNodesItem states a `type` that is one of `resource`, `annotation`")
        }
}
