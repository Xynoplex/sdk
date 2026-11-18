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
public data class GetAnnotationsResponse(
    @SerialName("annotations")
    public val annotations: kotlin.collections.List<Annotation>,
    /**
     * Total number of annotations
     */
    @SerialName("total")
    public val total: Double,
    @SerialName("motivation")
    public val motivation: Stated<Motivation> = Stated.Absent,
) {
    /** How Java makes a `GetAnnotationsResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotations: kotlin.collections.List<Annotation>,
        private val total: Double,
    ) {
        private var motivation: Stated<Motivation> = Stated.Absent

        public fun motivation(motivation: Motivation?): Builder {
            this.motivation = if (motivation == null) Stated.Null else Stated.Value(motivation)
            return this
        }

        public fun build(): GetAnnotationsResponse = GetAnnotationsResponse(annotations = annotations, total = total, motivation = motivation)
    }

    public companion object {
        /** A builder of a `GetAnnotationsResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotations: kotlin.collections.List<Annotation>, total: Double): Builder = Builder(annotations, total)
    }
}
