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
 * Emitted when a mark is submitted with its annotation body
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkSubmitEvent(
    /**
     * The '@id' of the resource the mark belongs to (W3C target.source). Routes the submit to the state unit bound to that resource — without it, N mounted units each create the annotation (N copies on N resources).
     */
    @SerialName("source")
    @get:JvmExposeBoxed
    public val source: ResourceId,
    @SerialName("motivation")
    public val motivation: Motivation,
    /**
     * One or more W3C selectors
     */
    @SerialName("selector")
    public val selector: AnnotationSelector,
    /**
     * Optional body. Omit for annotations whose motivation alone is meaningful (e.g. highlighting) or whose user-supplied content is empty (e.g. an assessing annotation saved without comment text). Shape matches Annotation.body.
     */
    @SerialName("body")
    public val body: AnnotationBodies? = null,
) {
    /** How Java makes a `MarkSubmitEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: ResourceId,
        private val motivation: Motivation,
        private val selector: AnnotationSelector,
    ) {
        private var body: AnnotationBodies? = null

        public fun body(body: AnnotationBodies?): Builder {
            this.body = body
            return this
        }

        public fun build(): MarkSubmitEvent = MarkSubmitEvent(source = source, motivation = motivation, selector = selector, body = body)
    }

    public companion object {
        /** A builder of a `MarkSubmitEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(source: ResourceId, motivation: Motivation, selector: AnnotationSelector): Builder = Builder(source, motivation, selector)
    }
}
