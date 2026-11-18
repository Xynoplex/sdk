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

@Serializable
@JsonIgnoreUnknownKeys
public data class GetAnnotationResponse(
    @SerialName("annotation")
    public val annotation: Annotation,
    @SerialName("resource")
    public val resource: ResourceDescriptor?,
    @SerialName("resolvedResource")
    public val resolvedResource: ResourceDescriptor?,
) {
    /** How Java makes a `GetAnnotationResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotation: Annotation,
        private val resource: ResourceDescriptor?,
        private val resolvedResource: ResourceDescriptor?,
    ) {
        public fun build(): GetAnnotationResponse = GetAnnotationResponse(annotation = annotation, resource = resource, resolvedResource = resolvedResource)
    }

    public companion object {
        /** A builder of a `GetAnnotationResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotation: Annotation, resource: ResourceDescriptor?, resolvedResource: ResourceDescriptor?): Builder = Builder(annotation, resource, resolvedResource)
    }
}
