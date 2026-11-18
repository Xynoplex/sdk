// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.KSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/** What an annotation's `body` holds: one body, or a non-empty list of them. There is no empty list: an annotation with nothing to say has no `body`. */
@Serializable(with = AnnotationBodiesSerializer::class)
public sealed interface AnnotationBodies {
    /** A member that is a `List<AnnotationBody>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<AnnotationBody>) : AnnotationBodies {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<AnnotationBody>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnnotationBodies.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object AnnotationBodiesSerializer : JsonContentPolymorphicSerializer<AnnotationBodies>(AnnotationBodies::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnnotationBodies", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AnnotationBodies> =
        firstThatFits<AnnotationBodies>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(AnnotationBody.serializer()) else emptyList()
                is JsonArray -> listOf(AnnotationBody.serializer(), AnnotationBodies.List.serializer())
                is JsonObject -> listOf(AnnotationBody.serializer())
            },
            "AnnotationBodies",
        )
}
