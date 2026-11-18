// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Text context around the annotation target */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusAnnotationSelected(
    /** Text appearing before the selected passage */
    public val before: String? = null,
    /** The selected text passage (the annotation target) */
    public val text: String,
    /** Text appearing after the selected passage */
    public val after: String? = null,
) {
    /** How Java makes a `GatheredContextFocusAnnotationSelected`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
    ) {
        private var before: String? = null
        private var after: String? = null

        public fun before(before: String?): Builder = apply { this.before = before }
        public fun after(after: String?): Builder = apply { this.after = after }

        public fun build(): GatheredContextFocusAnnotationSelected = GatheredContextFocusAnnotationSelected(before = before, text = text, after = after)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusAnnotationSelected` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(text: String): Builder = Builder(text)
    }
}
