// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable(with = BodyOperationAddItemSerializer::class)
public sealed interface BodyOperationAddItem

internal object BodyOperationAddItemSerializer : KindsUnionSerializer<BodyOperationAddItem>(
    BodyOperationAddItem::class,
    strings = { emptyList() },
    arrays = { emptyList() },
    objects = { listOf(TextualBody.serializer(), SpecificResource.serializer()) },
)
