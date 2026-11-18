// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** Emitted when a browse panel is opened */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowsePanelOpenEvent(
    public val panel: String,
    @get:JvmExposeBoxed
    public val scrollToAnnotationId: AnnotationId? = null,
    public val motivation: Motivation? = null,
) {
    /** How Java makes a `BrowsePanelOpenEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val panel: String,
    ) {
        private var scrollToAnnotationId: AnnotationId? = null
        private var motivation: Motivation? = null

        @JvmExposeBoxed
        public fun scrollToAnnotationId(scrollToAnnotationId: AnnotationId?): Builder = apply { this.scrollToAnnotationId = scrollToAnnotationId }

        public fun motivation(motivation: Motivation?): Builder = apply { this.motivation = motivation }

        public fun build(): BrowsePanelOpenEvent = BrowsePanelOpenEvent(panel = panel, scrollToAnnotationId = scrollToAnnotationId, motivation = motivation)
    }

    public companion object {
        /** A builder of a `BrowsePanelOpenEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(panel: String): Builder = Builder(panel)
    }
}
