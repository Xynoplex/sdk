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
public data class SemanticMatch(
    /**
     * The chunk text that matched
     */
    @SerialName("text")
    public val text: String,
    /**
     * Source resource ID
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * The source resource's display name, resolved from its view at gather time. Required: a match card must name its source, and corpus matches routinely come from outside the graph neighborhood, so there is no node to borrow a name from. A match whose source no longer resolves to a view is dropped by the producer rather than served nameless.
     */
    @SerialName("resourceName")
    public val resourceName: String,
    /**
     * Source annotation ID, if the match is from an annotation
     */
    @SerialName("annotationId")
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /**
     * Cosine similarity score (0-1)
     */
    @SerialName("score")
    public val score: Double,
    /**
     * Entity types on the matched passage
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    /**
     * True when this passage's text was recognized from pixels (OCR of a scanned page) rather than read from the document. Absent means read directly — the common case — so the flag is only present where it changes how the text should be trusted. It travels with the passage because a consumer receives the chunk with no document attached and cannot recompute how the text was obtained.
     */
    @SerialName("machineRead")
    public val machineRead: Boolean? = null,
) {
    /** How Java makes a `SemanticMatch`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
        private val resourceId: ResourceId,
        private val resourceName: String,
        private val score: Double,
    ) {
        private var annotationId: AnnotationId? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var machineRead: Boolean? = null

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder {
            this.annotationId = annotationId
            return this
        }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun machineRead(machineRead: Boolean?): Builder {
            this.machineRead = machineRead
            return this
        }

        public fun build(): SemanticMatch = SemanticMatch(text = text, resourceId = resourceId, resourceName = resourceName, annotationId = annotationId, score = score, entityTypes = entityTypes, machineRead = machineRead)
    }

    public companion object {
        /** A builder of a `SemanticMatch` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(text: String, resourceId: ResourceId, resourceName: String, score: Double): Builder = Builder(text, resourceId, resourceName, score)
    }
}
