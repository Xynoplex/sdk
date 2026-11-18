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
public data class CreateAnnotationRequest(
    @SerialName("motivation")
    public val motivation: Motivation,
    @SerialName("target")
    public val target: AnnotationTarget,
    /**
     * Optional body. Omit for annotations whose motivation alone is meaningful (highlighting) or whose user-supplied content is empty. Shape matches Annotation.body.
     */
    @SerialName("body")
    public val body: AnnotationBodies? = null,
) {
    /** How Java makes a `CreateAnnotationRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val motivation: Motivation,
        private val target: AnnotationTarget,
    ) {
        private var body: AnnotationBodies? = null

        public fun body(body: AnnotationBodies?): Builder {
            this.body = body
            return this
        }

        public fun build(): CreateAnnotationRequest = CreateAnnotationRequest(motivation = motivation, target = target, body = body)
    }

    public companion object {
        /** A builder of a `CreateAnnotationRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(motivation: Motivation, target: AnnotationTarget): Builder = Builder(motivation, target)
    }
}
