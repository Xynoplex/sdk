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
 * One job as the queue stores it: the job, and when it last showed life. The dead-worker sweep reads `lastProgressAt`: a running job whose worker has reported nothing for the configured interval is presumed dead. Where the queue keeps these records is the job storage layout, specs/src/jobs/storage.json.
 */
@Serializable
public data class JobRecord(
    @SerialName("job")
    public val job: Job,
    /**
     * When the job was created, claimed, checkpointed or last reported progress, as an ISO 8601 timestamp.
     */
    @SerialName("lastProgressAt")
    public val lastProgressAt: String,
) {
    /** How Java makes a `JobRecord`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val job: Job,
        private val lastProgressAt: String,
    ) {
        public fun build(): JobRecord = JobRecord(job = job, lastProgressAt = lastProgressAt)
    }

    public companion object {
        /** A builder of a `JobRecord` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(job: Job, lastProgressAt: String): Builder = Builder(job, lastProgressAt)
    }
}
