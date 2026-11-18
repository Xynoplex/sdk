// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** What this resource was generated from: the resource, and the annotation on it when the generation was for one. The resource's descriptor names the resource as `wasDerivedFrom`. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceCreatedPayloadGeneratedFrom(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
) {
    /** How Java makes a `ResourceCreatedPayloadGeneratedFrom`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var annotationId: AnnotationId? = null

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun build(): ResourceCreatedPayloadGeneratedFrom = ResourceCreatedPayloadGeneratedFrom(resourceId = resourceId, annotationId = annotationId)
    }

    public companion object {
        /** A builder of a `ResourceCreatedPayloadGeneratedFrom` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
