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

/** A completed job's result as the dispatcher stores it: the result its worker reported with `job:complete`, or an empty object when it reported none. */
@Serializable(with = JobStoredResultSerializer::class)
public sealed interface JobStoredResult {
    /** The empty object. */
    @Serializable
    public data object Empty : JobStoredResult
}

internal object JobStoredResultSerializer : JsonContentPolymorphicSerializer<JobStoredResult>(JobStoredResult::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobStoredResult", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobStoredResult> =
        firstThatFits<JobStoredResult>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf(JobResult.serializer()) else emptyList()
                is JsonArray -> listOf(JobResult.serializer())
                is JsonObject -> listOf(JobResult.serializer(), JobStoredResult.Empty.serializer())
            },
            "JobStoredResult",
        )
}
