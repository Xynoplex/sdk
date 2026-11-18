// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

@Serializable
public data class DirEntry(
    @EncodeDefault
    public val type: DirEntryType = DirEntryType.Dir,
    /** Entry name (basename) */
    public val name: String,
    /** Path relative to project root */
    public val path: String,
    /** Last modified time (ISO 8601) */
    public val mtime: String,
) : DirectoryEntry {
    /** How Java makes a `DirEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val path: String,
        private val mtime: String,
    ) {
        public fun build(): DirEntry = DirEntry(name = name, path = path, mtime = mtime)
    }

    public companion object {
        /** A builder of a `DirEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, path: String, mtime: String): Builder = Builder(name, path, mtime)
    }
}
