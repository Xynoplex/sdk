// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable(with = UpdateAnnotationBodyRequestOperationsItemSerializer::class)
public sealed interface UpdateAnnotationBodyRequestOperationsItem

internal object UpdateAnnotationBodyRequestOperationsItemSerializer : KindsUnionSerializer<UpdateAnnotationBodyRequestOperationsItem>(
    UpdateAnnotationBodyRequestOperationsItem::class,
    strings = { emptyList() },
    arrays = { emptyList() },
    objects = { listOf(BodyOperationAdd.serializer(), BodyOperationRemove.serializer(), BodyOperationReplace.serializer()) },
)
