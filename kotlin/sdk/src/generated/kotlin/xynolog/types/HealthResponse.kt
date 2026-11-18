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
 * Liveness: the process is up and serving. It asks nothing of the Archivist or the broker — a gateway that cannot reach them refuses to start, so one that answers here got past both at boot.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class HealthResponse(
    @SerialName("status")
    public val status: String,
    @SerialName("message")
    public val message: String,
    @SerialName("version")
    public val version: String,
    @SerialName("timestamp")
    public val timestamp: String,
) {
    /** How Java makes a `HealthResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val status: String,
        private val message: String,
        private val version: String,
        private val timestamp: String,
    ) {
        public fun build(): HealthResponse = HealthResponse(status = status, message = message, version = version, timestamp = timestamp)
    }

    public companion object {
        /** A builder of a `HealthResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(status: String, message: String, version: String, timestamp: String): Builder = Builder(status, message, version, timestamp)
    }
}
