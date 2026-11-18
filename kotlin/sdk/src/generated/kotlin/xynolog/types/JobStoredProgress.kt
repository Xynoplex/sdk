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

/** A running job's progress as the dispatcher stores it: the last JobProgress its worker reported with `job:report-progress`, or an empty object before the first report. */
@Serializable(with = JobStoredProgressSerializer::class)
public sealed interface JobStoredProgress {
    /** The empty object. */
    @Serializable
    public data object Empty : JobStoredProgress
}

internal object JobStoredProgressSerializer : JsonContentPolymorphicSerializer<JobStoredProgress>(JobStoredProgress::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobStoredProgress", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobStoredProgress> =
        firstThatFits<JobStoredProgress>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(JobProgress.serializer(), JobStoredProgress.Empty.serializer())
            },
            "JobStoredProgress",
        )
}
