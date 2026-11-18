// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when an entity type is clicked in the browse panel */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseEntityTypeClickedEvent(
    public val entityType: String,
) {
    /** How Java makes a `BrowseEntityTypeClickedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityType: String,
    ) {
        public fun build(): BrowseEntityTypeClickedEvent = BrowseEntityTypeClickedEvent(entityType = entityType)
    }

    public companion object {
        /** A builder of a `BrowseEntityTypeClickedEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityType: String): Builder = Builder(entityType)
    }
}
