// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

@Serializable(with = AnnotationBodyUpdatedPayloadOperationsItemSerializer::class)
public sealed interface AnnotationBodyUpdatedPayloadOperationsItem

internal object AnnotationBodyUpdatedPayloadOperationsItemSerializer : JsonContentPolymorphicSerializer<AnnotationBodyUpdatedPayloadOperationsItem>(AnnotationBodyUpdatedPayloadOperationsItem::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnnotationBodyUpdatedPayloadOperationsItem", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AnnotationBodyUpdatedPayloadOperationsItem> =
        firstThatFits<AnnotationBodyUpdatedPayloadOperationsItem>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(BodyOperationAdd.serializer(), BodyOperationRemove.serializer(), BodyOperationReplace.serializer())
            },
            "AnnotationBodyUpdatedPayloadOperationsItem",
        )
}
