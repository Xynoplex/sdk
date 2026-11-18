// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Emitted to draw attention to a resource: to one of its annotations, or, with no annotation, to the resource as a whole. The resource is always named. A focus on an annotation scrolls a viewer showing that resource to it, and a viewer showing a different resource ignores it — a deliberate ignore rather than a silent no-op. A focus on the resource as a whole brings that resource forward, opened if it is not open, at its top. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BeckonFocusEvent(
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /** The resource this focus applies to, always named. With an annotation it is a guard: a viewer showing a different resource ignores the event. With none it is the resource the focus brings forward. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `BeckonFocusEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var annotationId: AnnotationId? = null

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun build(): BeckonFocusEvent = BeckonFocusEvent(annotationId = annotationId, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `BeckonFocusEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
