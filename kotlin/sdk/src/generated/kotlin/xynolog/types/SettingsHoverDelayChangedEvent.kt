// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when the hover delay setting changes */
@Serializable
@JsonIgnoreUnknownKeys
public data class SettingsHoverDelayChangedEvent(
    public val hoverDelayMs: Long,
) {
    /** How Java makes a `SettingsHoverDelayChangedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val hoverDelayMs: Long,
    ) {
        public fun build(): SettingsHoverDelayChangedEvent = SettingsHoverDelayChangedEvent(hoverDelayMs = hoverDelayMs)
    }

    public companion object {
        /** A builder of a `SettingsHoverDelayChangedEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(hoverDelayMs: Long): Builder = Builder(hoverDelayMs)
    }
}
