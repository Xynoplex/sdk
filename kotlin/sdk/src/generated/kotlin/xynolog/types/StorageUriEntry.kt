// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** One entry of the storage-uri index: the file `projections/storage-uri/<ab>/<cd>/<sha256 of the URI, hex>.json` under the state directory. It answers which resource's content is at a place in the working tree. Written as JSON indented by two spaces, `uri` first. */
@Serializable
public data class StorageUriEntry(
    /** The `file://` URI of a place in the working tree, relative to the knowledge base's root. */
    public val uri: String,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `StorageUriEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val uri: String,
        private val resourceId: ResourceId,
    ) {
        public fun build(): StorageUriEntry = StorageUriEntry(uri = uri, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `StorageUriEntry` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(uri: String, resourceId: ResourceId): Builder = Builder(uri, resourceId)
    }
}
