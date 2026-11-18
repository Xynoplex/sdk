// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command to update a yielded resource's storage content. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldUpdateCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The caller's instruction for WHERE the bytes are — not a copy of the stored fact. The stored location lives on the resource's primary Representation (`Representation.storageUri`), which is its single home; this field is the message that puts it there. Working-tree URI, only file:// is supported (e.g. file://docs/overview.md). */
    public val storageUri: String,
    public val contentChecksum: String,
    public val byteSize: Long,
) {
    /** How Java makes a `YieldUpdateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val storageUri: String,
        private val contentChecksum: String,
        private val byteSize: Long,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): YieldUpdateCommand = YieldUpdateCommand(userId = userId, resourceId = resourceId, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize)
    }

    public companion object {
        /** A builder of a `YieldUpdateCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, storageUri: String, contentChecksum: String, byteSize: Long): Builder = Builder(resourceId, storageUri, contentChecksum, byteSize)
    }
}
