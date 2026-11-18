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
 * Some jobs, named by fields of the job description: a partial description, at the description's own paths. A job matches when every field stated here equals the job's. A `mark` filter always states its motivation.
 */
@Serializable(with = JobFilterSerializer::class)
public sealed interface JobFilter

internal object JobFilterSerializer : JsonContentPolymorphicSerializer<JobFilter>(JobFilter::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobFilter", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobFilter> =
        when (((element as? JsonObject)?.get("jobType") as? JsonPrimitive)?.content) {
            "mark" -> MarkJobFilter.serializer()
            "yield" -> YieldJobFilter.serializer()
            else -> throw SerializationException("a JobFilter states a `jobType` that is one of `mark`, `yield`")
        }
}
