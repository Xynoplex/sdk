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

/** PROV-O wasAttributedTo — every party responsible for this annotation, DERIVED by the knowledge base from `creator` and the verified executor of the write: `[creator, generator]` when one agent requested the work and software produced it; collapsed to the one agent when requester and producer are the same. Never accepted from an emitter. */
@Serializable(with = AnnotationWasAttributedToSerializer::class)
public sealed interface AnnotationWasAttributedTo {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : AnnotationWasAttributedTo {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<Agent>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnnotationWasAttributedTo.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object AnnotationWasAttributedToSerializer : JsonContentPolymorphicSerializer<AnnotationWasAttributedTo>(AnnotationWasAttributedTo::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnnotationWasAttributedTo", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AnnotationWasAttributedTo> =
        firstThatFits<AnnotationWasAttributedTo>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(Agent.serializer()) else emptyList()
                is JsonArray -> listOf(Agent.serializer(), AnnotationWasAttributedTo.List.serializer())
                is JsonObject -> listOf(Agent.serializer())
            },
            "AnnotationWasAttributedTo",
        )
}
