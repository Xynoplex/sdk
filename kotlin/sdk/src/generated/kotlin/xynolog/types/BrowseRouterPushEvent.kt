// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when the browse panel requests a router navigation */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseRouterPushEvent(
    public val path: String,
    public val reason: String? = null,
) {
    /** How Java makes a `BrowseRouterPushEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val path: String,
    ) {
        private var reason: String? = null

        public fun reason(reason: String?): Builder = apply { this.reason = reason }

        public fun build(): BrowseRouterPushEvent = BrowseRouterPushEvent(path = path, reason = reason)
    }

    public companion object {
        /** A builder of a `BrowseRouterPushEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(path: String): Builder = Builder(path)
    }
}
