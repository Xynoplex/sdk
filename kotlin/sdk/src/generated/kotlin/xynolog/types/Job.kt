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

/** A job as the dispatcher holds it. Its `status` decides which timestamps and outcome fields it carries. It is what a claim returns (`job:claimed`, always `running`) and what the queue stores, inside a JobRecord. */
@Serializable(with = JobSerializer::class)
public sealed interface Job

internal object JobSerializer : JsonContentPolymorphicSerializer<Job>(Job::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.Job", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<Job> =
        when (((element as? JsonObject)?.get("status") as? JsonPrimitive)?.content) {
            "pending" -> JobPending.serializer()
            "running" -> JobRunning.serializer()
            "complete" -> JobComplete.serializer()
            "failed" -> JobFailed.serializer()
            "cancelled" -> JobCancelled.serializer()
            else -> throw SerializationException("a Job states a `status` that is one of `pending`, `running`, `complete`, `failed`, `cancelled`")
        }
}
