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
 * Payload for mark:added domain event
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnnotationAddedPayload(
    @SerialName("annotation")
    public val annotation: Annotation,
    /**
     * SHA-256 of resource content at annotation time
     */
    @SerialName("contentChecksum")
    public val contentChecksum: String? = null,
) {
    /** How Java makes a `AnnotationAddedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotation: Annotation,
    ) {
        private var contentChecksum: String? = null

        public fun contentChecksum(contentChecksum: String?): Builder {
            this.contentChecksum = contentChecksum
            return this
        }

        public fun build(): AnnotationAddedPayload = AnnotationAddedPayload(annotation = annotation, contentChecksum = contentChecksum)
    }

    public companion object {
        /** A builder of a `AnnotationAddedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotation: Annotation): Builder = Builder(annotation)
    }
}
