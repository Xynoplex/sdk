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

/** Managed or referenced byte-level renditions of this resource. */
@Serializable(with = ResourceDescriptorRepresentationsSerializer::class)
public sealed interface ResourceDescriptorRepresentations {
    /** A member that is a `List<Representation>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Representation>) : ResourceDescriptorRepresentations {
        internal object Serializer : KSerializer<List> {
            private val value: KSerializer<kotlin.collections.List<Representation>> = kotlinx.serialization.serializer()

            override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorRepresentations.List", value.descriptor)

            override fun serialize(encoder: Encoder, value: List) {
                encoder.encodeSerializableValue(this.value, value.value)
            }

            override fun deserialize(decoder: Decoder): List = List(decoder.decodeSerializableValue(value))
        }
    }
}

internal object ResourceDescriptorRepresentationsSerializer : JsonContentPolymorphicSerializer<ResourceDescriptorRepresentations>(ResourceDescriptorRepresentations::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptorRepresentations", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ResourceDescriptorRepresentations> =
        firstThatFits<ResourceDescriptorRepresentations>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf(ResourceDescriptorRepresentations.List.serializer())
                is JsonObject -> listOf(Representation.serializer())
            },
            "ResourceDescriptorRepresentations",
        )
}
