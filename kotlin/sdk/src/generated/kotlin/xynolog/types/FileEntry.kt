// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

@Serializable
public data class FileEntry(
    @EncodeDefault
    public val type: FileEntryType = FileEntryType.File,
    /** Entry name (basename) */
    public val name: String,
    /** Path relative to project root */
    public val path: String,
    /** File size in bytes */
    public val size: Long,
    /** Last modified time (ISO 8601) */
    public val mtime: String,
    /** True if this file is a tracked resource in the Knowledge Base */
    public val tracked: Boolean,
    /** Resource ID (only when tracked is true) */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    /** Entity types assigned to this resource (only when tracked is true) */
    public val entityTypes: kotlin.collections.List<String>? = null,
    /** Number of annotations on this resource (only when tracked is true) */
    public val annotationCount: Long? = null,
    /** DID of the resource's creator — the first of its derived `wasAttributedTo`, the requester as the knowledge base recorded it (only when tracked is true) */
    public val creator: String? = null,
) : DirectoryEntry {
    /** How Java makes a `FileEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val path: String,
        private val size: Long,
        private val mtime: String,
        private val tracked: Boolean,
    ) {
        private var resourceId: ResourceId? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var annotationCount: Long? = null
        private var creator: String? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun annotationCount(annotationCount: Long?): Builder = apply { this.annotationCount = annotationCount }
        public fun creator(creator: String?): Builder = apply { this.creator = creator }

        public fun build(): FileEntry = FileEntry(name = name, path = path, size = size, mtime = mtime, tracked = tracked, resourceId = resourceId, entityTypes = entityTypes, annotationCount = annotationCount, creator = creator)
    }

    public companion object {
        /** A builder of a `FileEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, path: String, size: Long, mtime: String, tracked: Boolean): Builder = Builder(name, path, size, mtime, tracked)
    }
}
