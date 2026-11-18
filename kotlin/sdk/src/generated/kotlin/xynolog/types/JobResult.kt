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

/** What a job reports when it concludes without failing: a `mark` job's counts, the resource a `yield` job made, or a decline from either. A result has no discriminant of its own: the job description beside it says which job it answers, and the three share no member, so each is told from the others by what it alone carries. */
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
