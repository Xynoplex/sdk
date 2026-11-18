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

/** The parameters of a `mark` job, told apart by `motivation`. Each motivation takes its own parameters and no others: a parameter a job does not take is refused where the job is created. */
@Serializable(with = MarkJobParamsSerializer::class)
public sealed interface MarkJobParams

internal object MarkJobParamsSerializer : JsonContentPolymorphicSerializer<MarkJobParams>(MarkJobParams::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.MarkJobParams", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<MarkJobParams> =
        when (((element as? JsonObject)?.get("motivation") as? JsonPrimitive)?.content) {
            "highlighting" -> HighlightingJobParams.serializer()
            "commenting" -> CommentingJobParams.serializer()
            "assessing" -> AssessingJobParams.serializer()
            "linking" -> LinkingJobParams.serializer()
            "tagging" -> TaggingJobParams.serializer()
            else -> throw SerializationException("a MarkJobParams states a `motivation` that is one of `highlighting`, `commenting`, `assessing`, `linking`, `tagging`")
        }
}
