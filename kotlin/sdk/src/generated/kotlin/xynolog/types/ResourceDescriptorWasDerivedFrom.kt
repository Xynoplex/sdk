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
import xynolog.identifiers.ResourceId

/** W3C PROV: the resource, or resources, this one was derived from, each by its id */
@Serializable(with = ResourceDescriptorWasDerivedFromSerializer::class)
public sealed interface ResourceDescriptorWasDerivedFrom {
    /** A member that is a `ResourceId`, as the value itself. */
    @Serializable(with = ResourceId.Serializer::class)
    public data class ResourceId(public val value: xynolog.identifiers.ResourceId) : ResourceDescriptorWasDerivedFrom {
        internal object Serializer : KSerializer<ResourceId> {
            private val value: KSerializer<xynolog.identifiers.ResourceId> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorWasDerivedFrom.ResourceId", value.descriptor)

            override fun serialize(encoder: Encoder, value: ResourceId) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): ResourceId = ResourceId(decoder.decodeSerializableValue(value))
        }
    }

    /** A member that is a `List<ResourceId>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<ResourceId>) : ResourceDescriptorWasDerivedFrom {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<ResourceId>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorWasDerivedFrom.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ResourceDescriptorWasDerivedFromSerializer : JsonContentPolymorphicSerializer<ResourceDescriptorWasDerivedFrom>(ResourceDescriptorWasDerivedFrom::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorWasDerivedFrom", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ResourceDescriptorWasDerivedFrom> =
        firstThatFits<ResourceDescriptorWasDerivedFrom>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(ResourceDescriptorWasDerivedFrom.ResourceId.serializer()) else emptyList()
                is JsonArray -> listOf(ResourceDescriptorWasDerivedFrom.List.serializer())
                is JsonObject -> listOf()
            },
            "ResourceDescriptorWasDerivedFrom",
        )
}
