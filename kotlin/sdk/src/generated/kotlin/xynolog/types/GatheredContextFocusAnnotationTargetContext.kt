// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Context about the annotation's link target. Dormant — produced/exposed but not yet consumed. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusAnnotationTargetContext(
    public val content: String,
    public val summary: String? = null,
) {
    /** How Java makes a `GatheredContextFocusAnnotationTargetContext`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val content: String,
    ) {
        private var summary: String? = null

        public fun summary(summary: String?): Builder = apply { this.summary = summary }

        public fun build(): GatheredContextFocusAnnotationTargetContext = GatheredContextFocusAnnotationTargetContext(content = content, summary = summary)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusAnnotationTargetContext` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(content: String): Builder = Builder(content)
    }
}
