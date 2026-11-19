// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The annotation a mark state unit is composing, from the selection a request asked for, until it is submitted or cancelled. */
@Serializable
public data class PendingAnnotation(
    public val selector: AnnotationSelector,
    public val motivation: Motivation,
) {
    /** How Java makes a `PendingAnnotation`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val selector: AnnotationSelector,
        private val motivation: Motivation,
    ) {
        public fun build(): PendingAnnotation = PendingAnnotation(selector = selector, motivation = motivation)
    }

    public companion object {
        /** A builder of a `PendingAnnotation` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(selector: AnnotationSelector, motivation: Motivation): Builder = Builder(selector, motivation)
    }
}
