// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable(with = BodyOperationReplaceNewItemSerializer::class)
public sealed interface BodyOperationReplaceNewItem

internal object BodyOperationReplaceNewItemSerializer : KindsUnionSerializer<BodyOperationReplaceNewItem>(
    BodyOperationReplaceNewItem::class,
    strings = { emptyList() },
    arrays = { emptyList() },
    objects = { listOf(TextualBody.serializer(), SpecificResource.serializer()) },
)
