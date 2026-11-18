// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Annotation-anchored focus. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusAnnotation(
    @EncodeDefault
    public val kind: GatheredContextFocusAnnotationKind = GatheredContextFocusAnnotationKind.Annotation,
    /** The annotation this context was gathered for */
    public val annotation: Annotation,
    /** The resource containing the annotation */
    public val sourceResource: ResourceDescriptor,
    /** Text context around the annotation target */
    public val selected: GatheredContextFocusAnnotationSelected? = null,
    /** User-provided hint to supplement or replace the selected text for search and generation */
    public val userHint: String? = null,
    /** The resource the annotation links to, if it is a resolved reference. Dormant capability — produced/exposed but not yet consumed. */
    public val targetResource: ResourceDescriptor? = null,
    /** Context about the annotation's link target. Dormant — produced/exposed but not yet consumed. */
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

        public fun selected(selected: GatheredContextFocusAnnotationSelected?): Builder = apply { this.selected = selected }
        public fun userHint(userHint: String?): Builder = apply { this.userHint = userHint }
        public fun targetResource(targetResource: ResourceDescriptor?): Builder = apply { this.targetResource = targetResource }
        public fun targetContext(targetContext: GatheredContextFocusAnnotationTargetContext?): Builder = apply { this.targetContext = targetContext }

        public fun build(): GatheredContextFocusAnnotation = GatheredContextFocusAnnotation(annotation = annotation, sourceResource = sourceResource, selected = selected, userHint = userHint, targetResource = targetResource, targetContext = targetContext)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusAnnotation` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotation: Annotation, sourceResource: ResourceDescriptor): Builder = Builder(annotation, sourceResource)
    }
}
