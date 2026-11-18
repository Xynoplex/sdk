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

/** The gather anchor. Discriminated on `kind`. */
@Serializable(with = GatheredContextFocusSerializer::class)
public sealed interface GatheredContextFocus

internal object GatheredContextFocusSerializer : JsonContentPolymorphicSerializer<GatheredContextFocus>(GatheredContextFocus::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.GatheredContextFocus", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<GatheredContextFocus> =
        firstThatFits<GatheredContextFocus>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(GatheredContextFocusAnnotation.serializer(), GatheredContextFocusResource.serializer())
            },
            "GatheredContextFocus",
        )
}
