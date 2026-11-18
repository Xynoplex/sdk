// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Emitted when the user requests a new mark (annotation) on a resource */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkRequestedEvent(
    /** The '@id' of the resource the mark belongs to (W3C target.source). Routes the event to the right viewer/state unit when a host mounts many viewers on one session. */
    @get:JvmExposeBoxed
    public val source: ResourceId,
    /** One or more W3C selectors */
    public val selector: AnnotationSelector,
    public val motivation: Motivation,
) {
    /** How Java makes a `MarkRequestedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val source: ResourceId,
        private val selector: AnnotationSelector,
        private val motivation: Motivation,
    ) {
        public fun build(): MarkRequestedEvent = MarkRequestedEvent(source = source, selector = selector, motivation = motivation)
    }

    public companion object {
        /** A builder of a `MarkRequestedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(source: ResourceId, selector: AnnotationSelector, motivation: Motivation): Builder = Builder(source, selector, motivation)
    }
}
