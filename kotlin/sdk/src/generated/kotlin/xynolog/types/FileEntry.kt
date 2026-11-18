// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

@Serializable
public data class FileEntry(
    @SerialName("type")
    @EncodeDefault
    public val type: FileEntryType = FileEntryType.File,
    /**
     * Entry name (basename)
     */
    @SerialName("name")
    public val name: String,
    /**
     * Path relative to project root
     */
    @SerialName("path")
    public val path: String,
    /**
     * File size in bytes
     */
    @SerialName("size")
    public val size: Long,
    /**
     * Last modified time (ISO 8601)
     */
    @SerialName("mtime")
    public val mtime: String,
    /**
     * True if this file is a tracked resource in the Knowledge Base
     */
    @SerialName("tracked")
    public val tracked: Boolean,
    /**
     * Resource ID (only when tracked is true)
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    /**
     * Entity types assigned to this resource (only when tracked is true)
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    /**
     * Number of annotations on this resource (only when tracked is true)
     */
    @SerialName("annotationCount")
    public val annotationCount: Long? = null,
    /**
     * DID of the resource's creator — the first of its derived `wasAttributedTo`, the requester as the knowledge base recorded it (only when tracked is true)
     */
    @SerialName("creator")
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
        public fun resourceId(resourceId: ResourceId?): Builder {
            this.resourceId = resourceId
            return this
        }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun annotationCount(annotationCount: Long?): Builder {
            this.annotationCount = annotationCount
            return this
        }

        public fun creator(creator: String?): Builder {
            this.creator = creator
            return this
        }

        public fun build(): FileEntry = FileEntry(name = name, path = path, size = size, mtime = mtime, tracked = tracked, resourceId = resourceId, entityTypes = entityTypes, annotationCount = annotationCount, creator = creator)
    }

    public companion object {
        /** A builder of a `FileEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, path: String, size: Long, mtime: String, tracked: Boolean): Builder = Builder(name, path, size, mtime, tracked)
    }
}
