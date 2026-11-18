// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Emitted when a mark is submitted with its annotation body */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkSubmitEvent(
    /** The '@id' of the resource the mark belongs to (W3C target.source). Routes the submit to the state unit bound to that resource — without it, N mounted units each create the annotation (N copies on N resources). */
    @get:JvmExposeBoxed
    public val source: ResourceId,
    public val motivation: Motivation,
    /** One or more W3C selectors */
    public val selector: AnnotationSelector,
    /** Optional body. Omit for annotations whose motivation alone is meaningful (e.g. highlighting) or whose user-supplied content is empty (e.g. an assessing annotation saved without comment text). Shape matches Annotation.body. */
    public val body: AnnotationBodies? = null,
) {
    /** How Java makes a `MarkSubmitEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: ResourceId,
        private val motivation: Motivation,
        private val selector: AnnotationSelector,
    ) {
        private var body: AnnotationBodies? = null

        public fun body(body: AnnotationBodies?): Builder = apply { this.body = body }

        public fun build(): MarkSubmitEvent = MarkSubmitEvent(source = source, motivation = motivation, selector = selector, body = body)
    }

    public companion object {
        /** A builder of a `MarkSubmitEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(source: ResourceId, motivation: Motivation, selector: AnnotationSelector): Builder = Builder(source, motivation, selector)
    }
}
