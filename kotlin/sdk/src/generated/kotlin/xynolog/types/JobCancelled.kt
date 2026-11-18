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
 * A job cancelled before it concluded.
 */
@Serializable
public data class JobCancelled(
    @SerialName("status")
    @EncodeDefault
    public val status: JobCancelledStatus = JobCancelledStatus.Cancelled,
    @SerialName("metadata")
    public val metadata: JobMetadata,
    @SerialName("params")
    public val params: JobParams,
    /**
     * When its claim was made; absent when it was cancelled while pending.
     */
    @SerialName("startedAt")
    public val startedAt: String? = null,
    /**
     * When it was cancelled.
     */
    @SerialName("completedAt")
    public val completedAt: String,
) : Job {
    /** How Java makes a `JobCancelled`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
        private val completedAt: String,
    ) {
        private var startedAt: String? = null

        public fun startedAt(startedAt: String?): Builder {
            this.startedAt = startedAt
            return this
        }

        public fun build(): JobCancelled = JobCancelled(metadata = metadata, params = params, startedAt = startedAt, completedAt = completedAt)
    }

    public companion object {
        /** A builder of a `JobCancelled` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams, completedAt: String): Builder = Builder(metadata, params, completedAt)
    }
}
