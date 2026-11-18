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

/** One W3C selector: a way of finding a segment of a resource. Tell them apart by `type`, which is required on each and single-valued. */
@Serializable(with = SelectorSerializer::class)
public sealed interface Selector : AnnotationSelector

internal object SelectorSerializer : JsonContentPolymorphicSerializer<Selector>(Selector::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.Selector", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<Selector> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "TextPositionSelector" -> TextPositionSelector.serializer()
            "TextQuoteSelector" -> TextQuoteSelector.serializer()
            "SvgSelector" -> SvgSelector.serializer()
            "FragmentSelector" -> FragmentSelector.serializer()
            else -> throw SerializationException("a Selector states a `type` that is one of `TextPositionSelector`, `TextQuoteSelector`, `SvgSelector`, `FragmentSelector`")
        }
}
