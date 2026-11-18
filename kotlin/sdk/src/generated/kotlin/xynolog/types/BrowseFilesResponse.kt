// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable
public data class BrowseFilesResponse(
    /** The directory path that was listed, relative to project root */
    public val path: String,
    public val entries: kotlin.collections.List<DirectoryEntry>,
) {
    /** How Java makes a `BrowseFilesResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val path: String,
        private val entries: kotlin.collections.List<DirectoryEntry>,
    ) {
        public fun build(): BrowseFilesResponse = BrowseFilesResponse(path = path, entries = entries)
    }

    public companion object {
        /** A builder of a `BrowseFilesResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(path: String, entries: kotlin.collections.List<DirectoryEntry>): Builder = Builder(path, entries)
    }
}
