// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseDirectoryResultResponse(
    public val path: String,
    public val entries: kotlin.collections.List<DirectoryEntry>,
) {
    /** How Java makes a `BrowseDirectoryResultResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val path: String,
        private val entries: kotlin.collections.List<DirectoryEntry>,
    ) {
        public fun build(): BrowseDirectoryResultResponse = BrowseDirectoryResultResponse(path = path, entries = entries)
    }

    public companion object {
        /** A builder of a `BrowseDirectoryResultResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(path: String, entries: kotlin.collections.List<DirectoryEntry>): Builder = Builder(path, entries)
    }
}
