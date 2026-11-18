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

/** A job's worker says the job is complete. The result it carries is its verb's: a `mark` job's counts or the resource a `yield` job made, or a decline from either. A completion whose result is the other verb's is refused where the command is admitted. */
@Serializable(with = JobCompleteCommandSerializer::class)
public sealed interface JobCompleteCommand

internal object JobCompleteCommandSerializer : JsonContentPolymorphicSerializer<JobCompleteCommand>(JobCompleteCommand::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobCompleteCommand", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobCompleteCommand> =
        when (((element as? JsonObject)?.get("jobType") as? JsonPrimitive)?.content) {
            "mark" -> MarkJobCompleteCommand.serializer()
            "yield" -> YieldJobCompleteCommand.serializer()
            else -> throw SerializationException("a JobCompleteCommand states a `jobType` that is one of `mark`, `yield`")
        }
}
