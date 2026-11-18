// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** Bus command to create a cloned resource from a clone token. Bytes are stored by the upload path BEFORE this command is emitted, because bytes travel over HTTP and never over the bus — the command carries the storage coordinates, never content. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldCloneCreateCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    public val token: String,
    public val name: String,
    /** Where the caller already wrote the clone's bytes — an instruction, not a copy of the stored fact (that lives on the primary Representation). Bytes are stored through the byte door BEFORE this command is sent, so this names an existing file. Working-tree URI, only file:// is supported. */
    public val storageUri: String,
    public val contentChecksum: String,
    public val byteSize: Long,
    public val format: ContentFormat,
    public val archiveOriginal: Boolean? = null,
) {
    /** How Java makes a `YieldCloneCreateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
        private val name: String,
        private val storageUri: String,
        private val contentChecksum: String,
        private val byteSize: Long,
        private val format: ContentFormat,
    ) {
        private var userId: UserId? = null
        private var archiveOriginal: Boolean? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun archiveOriginal(archiveOriginal: Boolean?): Builder = apply { this.archiveOriginal = archiveOriginal }

        public fun build(): YieldCloneCreateCommand = YieldCloneCreateCommand(userId = userId, token = token, name = name, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize, format = format, archiveOriginal = archiveOriginal)
    }

    public companion object {
        /** A builder of a `YieldCloneCreateCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String, name: String, storageUri: String, contentChecksum: String, byteSize: Long, format: ContentFormat): Builder = Builder(token, name, storageUri, contentChecksum, byteSize, format)
    }
}
