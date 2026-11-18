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
 * Command payload sent on the bind:initiate bus channel to start a bind flow.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class BindInitiateCommand(
    /**
     * Branded AnnotationId of the annotation being bound
     */
    @SerialName("annotationId")
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    /**
     * Branded ResourceId of the resource being bound to
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * Default title for the bound annotation
     */
    @SerialName("defaultTitle")
    public val defaultTitle: String,
    /**
     * Entity types to associate with the annotation
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `BindInitiateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
        private val defaultTitle: String,
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        public fun build(): BindInitiateCommand = BindInitiateCommand(annotationId = annotationId, resourceId = resourceId, defaultTitle = defaultTitle, entityTypes = entityTypes)
    }

    public companion object {
        /** A builder of a `BindInitiateCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, resourceId: ResourceId, defaultTitle: String, entityTypes: kotlin.collections.List<String>): Builder = Builder(annotationId, resourceId, defaultTitle, entityTypes)
    }
}
