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

/** PROV-O wasAttributedTo, derived at write time: the cloner alone. The value the resource view carries. */
@Serializable(with = ResourceClonedPayloadWasAttributedToSerializer::class)
public sealed interface ResourceClonedPayloadWasAttributedTo {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ResourceClonedPayloadWasAttributedTo {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<Agent>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceClonedPayloadWasAttributedTo.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ResourceClonedPayloadWasAttributedToSerializer : JsonContentPolymorphicSerializer<ResourceClonedPayloadWasAttributedTo>(ResourceClonedPayloadWasAttributedTo::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceClonedPayloadWasAttributedTo", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ResourceClonedPayloadWasAttributedTo> =
        firstThatFits<ResourceClonedPayloadWasAttributedTo>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(Agent.serializer()) else emptyList()
                is JsonArray -> listOf(Agent.serializer(), ResourceClonedPayloadWasAttributedTo.List.serializer())
                is JsonObject -> listOf(Agent.serializer())
            },
            "ResourceClonedPayloadWasAttributedTo",
        )
}
