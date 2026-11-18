// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * What a job reports when it concludes without failing: a `mark` job's counts, the resource a `yield` job made, or a decline from either. A result has no discriminant of its own: the job description beside it says which job it answers, and the three share no member, so each is told from the others by what it alone carries.
 */
@Serializable(with = JobResultSerializer::class)
public sealed interface JobResult : JobStoredResult

internal object JobResultSerializer : JsonContentPolymorphicSerializer<JobResult>(JobResult::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobResult", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobResult> =
        firstThatFits<JobResult>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(MarkJobDone.serializer(), YieldJobDone.serializer(), JobDeclined.serializer())
            },
            "JobResult",
        )
}
