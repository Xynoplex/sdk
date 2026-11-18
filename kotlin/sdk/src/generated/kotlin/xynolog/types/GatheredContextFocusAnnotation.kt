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
 * Annotation-anchored focus.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusAnnotation(
    @SerialName("kind")
    @EncodeDefault
    public val kind: GatheredContextFocusAnnotationKind = GatheredContextFocusAnnotationKind.Annotation,
    /**
     * The annotation this context was gathered for
     */
    @SerialName("annotation")
    public val annotation: Annotation,
    /**
     * The resource containing the annotation
     */
    @SerialName("sourceResource")
    public val sourceResource: ResourceDescriptor,
    /**
     * Text context around the annotation target
     */
    @SerialName("selected")
    public val selected: GatheredContextFocusAnnotationSelected? = null,
    /**
     * User-provided hint to supplement or replace the selected text for search and generation
     */
    @SerialName("userHint")
    public val userHint: String? = null,
    /**
     * The resource the annotation links to, if it is a resolved reference. Dormant capability — produced/exposed but not yet consumed.
     */
    @SerialName("targetResource")
    public val targetResource: ResourceDescriptor? = null,
    /**
     * Context about the annotation's link target. Dormant — produced/exposed but not yet consumed.
     */
    @SerialName("targetContext")
    public val targetContext: GatheredContextFocusAnnotationTargetContext? = null,
) : GatheredContextFocus {
    /** How Java makes a `GatheredContextFocusAnnotation`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotation: Annotation,
        private val sourceResource: ResourceDescriptor,
    ) {
        private var selected: GatheredContextFocusAnnotationSelected? = null
        private var userHint: String? = null
        private var targetResource: ResourceDescriptor? = null
        private var targetContext: GatheredContextFocusAnnotationTargetContext? = null

        public fun selected(selected: GatheredContextFocusAnnotationSelected?): Builder {
            this.selected = selected
            return this
        }

        public fun userHint(userHint: String?): Builder {
            this.userHint = userHint
            return this
        }

        public fun targetResource(targetResource: ResourceDescriptor?): Builder {
            this.targetResource = targetResource
            return this
        }

        public fun targetContext(targetContext: GatheredContextFocusAnnotationTargetContext?): Builder {
            this.targetContext = targetContext
            return this
        }

        public fun build(): GatheredContextFocusAnnotation = GatheredContextFocusAnnotation(annotation = annotation, sourceResource = sourceResource, selected = selected, userHint = userHint, targetResource = targetResource, targetContext = targetContext)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusAnnotation` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotation: Annotation, sourceResource: ResourceDescriptor): Builder = Builder(annotation, sourceResource)
    }
}
