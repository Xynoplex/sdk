// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when the UI theme setting changes */
@Serializable
@JsonIgnoreUnknownKeys
public data class SettingsThemeChangedEvent(
    public val theme: SettingsThemeChangedEventTheme,
) {
    /** How Java makes a `SettingsThemeChangedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val theme: SettingsThemeChangedEventTheme,
    ) {
        public fun build(): SettingsThemeChangedEvent = SettingsThemeChangedEvent(theme = theme)
    }

    public companion object {
        /** A builder of a `SettingsThemeChangedEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(theme: SettingsThemeChangedEventTheme): Builder = Builder(theme)
    }
}
