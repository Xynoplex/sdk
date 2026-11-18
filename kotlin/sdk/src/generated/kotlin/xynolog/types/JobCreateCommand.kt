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

/** Create a job. A job description is its `jobType` and enough parameters to be well formed: a `mark` job names its resource and, in its parameters, its motivation; a `yield` job names its context. */
@Serializable(with = JobCreateCommandSerializer::class)
public sealed interface JobCreateCommand

internal object JobCreateCommandSerializer : JsonContentPolymorphicSerializer<JobCreateCommand>(JobCreateCommand::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobCreateCommand", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobCreateCommand> =
        when (((element as? JsonObject)?.get("jobType") as? JsonPrimitive)?.content) {
            "mark" -> MarkJobCreateCommand.serializer()
            "yield" -> YieldJobCreateCommand.serializer()
            else -> throw SerializationException("a JobCreateCommand states a `jobType` that is one of `mark`, `yield`")
        }
}
