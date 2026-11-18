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
 * W3C Web Annotation target object - source is required, selector is optional
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnnotationTarget(
    /**
     * Stated by the annotation of a span: the target is a part of its source, which the selector picks out. An annotation of a resource as a whole states none.
     */
    @SerialName("type")
    public val type: AnnotationTargetType? = null,
    /**
     * The id of the resource being annotated
     */
    @SerialName("source")
    @get:JvmExposeBoxed
    public val source: ResourceId,
    /**
     * Optional selector to identify a specific segment of the source resource
     */
    @SerialName("selector")
    public val selector: AnnotationSelector? = null,
) : AnnotationTargetValue {
    /** How Java makes a `AnnotationTarget`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: ResourceId,
    ) {
        private var type: AnnotationTargetType? = null
        private var selector: AnnotationSelector? = null

        public fun type(type: AnnotationTargetType?): Builder {
            this.type = type
            return this
        }

        public fun selector(selector: AnnotationSelector?): Builder {
            this.selector = selector
            return this
        }

        public fun build(): AnnotationTarget = AnnotationTarget(type = type, source = source, selector = selector)
    }

    public companion object {
        /** A builder of a `AnnotationTarget` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(source: ResourceId): Builder = Builder(source)
    }
}
