// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when a link is clicked in the browse panel */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseLinkClickedEvent(
    public val href: String,
    public val label: String? = null,
) {
    /** How Java makes a `BrowseLinkClickedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val href: String,
    ) {
        private var label: String? = null

        public fun label(label: String?): Builder = apply { this.label = label }

        public fun build(): BrowseLinkClickedEvent = BrowseLinkClickedEvent(href = href, label = label)
    }

    public companion object {
        /** A builder of a `BrowseLinkClickedEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(href: String): Builder = Builder(href)
    }
}
