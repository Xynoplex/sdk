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
 * A job its worker completed.
 */
@Serializable
public data class JobComplete(
    @SerialName("status")
    @EncodeDefault
    public val status: JobCompleteStatus = JobCompleteStatus.Complete,
    @SerialName("metadata")
    public val metadata: JobMetadata,
    @SerialName("params")
    public val params: JobParams,
    /**
     * When the claim that completed it was made.
     */
    @SerialName("startedAt")
    public val startedAt: String,
    /**
     * When it completed.
     */
    @SerialName("completedAt")
    public val completedAt: String,
    @SerialName("result")
    public val result: JobStoredResult,
) : Job {
    /** How Java makes a `JobComplete`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val metadata: JobMetadata,
        private val params: JobParams,
        private val startedAt: String,
        private val completedAt: String,
        private val result: JobStoredResult,
    ) {
        public fun build(): JobComplete = JobComplete(metadata = metadata, params = params, startedAt = startedAt, completedAt = completedAt, result = result)
    }

    public companion object {
        /** A builder of a `JobComplete` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(metadata: JobMetadata, params: JobParams, startedAt: String, completedAt: String, result: JobStoredResult): Builder = Builder(metadata, params, startedAt, completedAt, result)
    }
}
