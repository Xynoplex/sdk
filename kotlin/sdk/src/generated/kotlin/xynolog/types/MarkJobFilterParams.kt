// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable
public data class MarkJobFilterParams(
    public val motivation: Motivation,
) {
    /** How Java makes a `MarkJobFilterParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val motivation: Motivation,
    ) {
        public fun build(): MarkJobFilterParams = MarkJobFilterParams(motivation = motivation)
    }

    public companion object {
        /** A builder of a `MarkJobFilterParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(motivation: Motivation): Builder = Builder(motivation)
    }
}
