// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when a browse panel is toggled */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowsePanelToggleEvent(
    public val panel: String,
) {
    /** How Java makes a `BrowsePanelToggleEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val panel: String,
    ) {
        public fun build(): BrowsePanelToggleEvent = BrowsePanelToggleEvent(panel = panel)
    }

    public companion object {
        /** A builder of a `BrowsePanelToggleEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(panel: String): Builder = Builder(panel)
    }
}
