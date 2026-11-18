// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Request payload sent on the gather:requested bus channel to gather context for an annotation. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherAnnotationRequest(
    /** Branded AnnotationId of the annotation to gather context for */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    /** Branded ResourceId of the resource the annotation belongs to */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val options: GatherAnnotationOptions? = null,
) {
    /** How Java makes a `GatherAnnotationRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
    ) {
        private var options: GatherAnnotationOptions? = null

        public fun options(options: GatherAnnotationOptions?): Builder = apply { this.options = options }

        public fun build(): GatherAnnotationRequest = GatherAnnotationRequest(annotationId = annotationId, resourceId = resourceId, options = options)
    }

    public companion object {
        /** A builder of a `GatherAnnotationRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, resourceId: ResourceId): Builder = Builder(annotationId, resourceId)
    }
}
