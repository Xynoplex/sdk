// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Request to browse a directory listing */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseDirectoryRequest(
    public val path: String,
    public val sort: BrowseDirectoryRequestSort? = null,
) {
    /** How Java makes a `BrowseDirectoryRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val path: String,
    ) {
        private var sort: BrowseDirectoryRequestSort? = null

        public fun sort(sort: BrowseDirectoryRequestSort?): Builder = apply { this.sort = sort }

        public fun build(): BrowseDirectoryRequest = BrowseDirectoryRequest(path = path, sort = sort)
    }

    public companion object {
        /** A builder of a `BrowseDirectoryRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(path: String): Builder = Builder(path)
    }
}
