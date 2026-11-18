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

/** An annotation's body: a TextualBody carries text the annotation states (entity tags, descriptions, comments), a SpecificResource points at what it links to. Tell them apart by `type`, which is required on both and single-valued — a consumer never has to probe for which fields happen to be present. */
@Serializable(with = AnnotationBodySerializer::class)
public sealed interface AnnotationBody : AnnotationBodies

internal object AnnotationBodySerializer : JsonContentPolymorphicSerializer<AnnotationBody>(AnnotationBody::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnnotationBody", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AnnotationBody> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "TextualBody" -> TextualBody.serializer()
            "SpecificResource" -> SpecificResource.serializer()
            else -> throw SerializationException("a AnnotationBody states a `type` that is one of `TextualBody`, `SpecificResource`")
        }
}
