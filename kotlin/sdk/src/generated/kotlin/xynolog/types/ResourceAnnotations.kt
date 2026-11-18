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
 * The annotations on one resource, as its materialized view holds them.
 */
@Serializable
public data class ResourceAnnotations(
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * Each annotation as the `mark:added` event that recorded it carried it, with the body changes recorded since applied. In the order they were first recorded.
     */
    @SerialName("annotations")
    public val annotations: kotlin.collections.List<Annotation>,
    /**
     * How many of the resource's events the view has applied.
     */
    @SerialName("version")
    public val version: Long,
    /**
     * The timestamp of the last event applied; the empty string before any.
     */
    @SerialName("updatedAt")
    public val updatedAt: String,
) {
    /** How Java makes a `ResourceAnnotations`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val annotations: kotlin.collections.List<Annotation>,
        private val version: Long,
        private val updatedAt: String,
    ) {
        public fun build(): ResourceAnnotations = ResourceAnnotations(resourceId = resourceId, annotations = annotations, version = version, updatedAt = updatedAt)
    }

    public companion object {
        /** A builder of a `ResourceAnnotations` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, annotations: kotlin.collections.List<Annotation>, version: Long, updatedAt: String): Builder = Builder(resourceId, annotations, version, updatedAt)
    }
}
