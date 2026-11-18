// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Emitted when resources are reordered in the browse panel */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseResourceReorderEvent(
    public val oldIndex: Long,
    public val newIndex: Long,
) {
    /** How Java makes a `BrowseResourceReorderEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val oldIndex: Long,
        private val newIndex: Long,
    ) {
        public fun build(): BrowseResourceReorderEvent = BrowseResourceReorderEvent(oldIndex = oldIndex, newIndex = newIndex)
    }

    public companion object {
        /** A builder of a `BrowseResourceReorderEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(oldIndex: Long, newIndex: Long): Builder = Builder(oldIndex, newIndex)
    }
}
