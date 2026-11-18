// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable(with = KnowledgeGraphNodesItemSerializer::class)
public sealed interface KnowledgeGraphNodesItem

internal object KnowledgeGraphNodesItemSerializer : TaggedUnionSerializer<KnowledgeGraphNodesItem>(
    KnowledgeGraphNodesItem::class,
    "type",
    members = { mapOf("resource" to GraphResourceNode.serializer(), "annotation" to GraphAnnotationNode.serializer()) },
)
