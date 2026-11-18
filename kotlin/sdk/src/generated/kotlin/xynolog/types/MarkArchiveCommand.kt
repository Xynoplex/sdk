// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command to archive a resource and optionally remove its file. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkArchiveCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Optional: where the resource's bytes live, so the archive can act on the file. An instruction to this handler, not a copy of the stored fact (that lives on the primary Representation). Working-tree URI, only file:// is supported. */
    public val storageUri: String? = null,
    public val keepFile: Boolean? = null,
) {
    /** How Java makes a `MarkArchiveCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var userId: UserId? = null
        private var storageUri: String? = null
        private var keepFile: Boolean? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun storageUri(storageUri: String?): Builder = apply { this.storageUri = storageUri }
        public fun keepFile(keepFile: Boolean?): Builder = apply { this.keepFile = keepFile }

        public fun build(): MarkArchiveCommand = MarkArchiveCommand(userId = userId, resourceId = resourceId, storageUri = storageUri, keepFile = keepFile)
    }

    public companion object {
        /** A builder of a `MarkArchiveCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
