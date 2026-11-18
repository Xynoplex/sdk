// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable(with = MarkUpdateBodyCommandOperationsItemSerializer::class)
public sealed interface MarkUpdateBodyCommandOperationsItem

internal object MarkUpdateBodyCommandOperationsItemSerializer : KindsUnionSerializer<MarkUpdateBodyCommandOperationsItem>(
    MarkUpdateBodyCommandOperationsItem::class,
    strings = { emptyList() },
    arrays = { emptyList() },
    objects = { listOf(BodyOperationAdd.serializer(), BodyOperationRemove.serializer(), BodyOperationReplace.serializer()) },
)
