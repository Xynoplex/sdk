// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when the UI locale setting changes */
@Serializable
@JsonIgnoreUnknownKeys
public data class SettingsLocaleChangedEvent(
    public val locale: String,
) {
    /** How Java makes a `SettingsLocaleChangedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val locale: String,
    ) {
        public fun build(): SettingsLocaleChangedEvent = SettingsLocaleChangedEvent(locale = locale)
    }

    public companion object {
        /** A builder of a `SettingsLocaleChangedEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(locale: String): Builder = Builder(locale)
    }
}
