// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command to unarchive a previously archived resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkUnarchiveCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Optional: where the resource's bytes are expected to be. When present the handler VERIFIES the file exists and fails loudly if it does not, rather than succeeding as a no-op. An instruction, not a copy of the stored fact (that lives on the primary Representation). Working-tree URI, only file:// is supported. */
    public val storageUri: String? = null,
) {
    /** How Java makes a `MarkUnarchiveCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var userId: UserId? = null
        private var storageUri: String? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun storageUri(storageUri: String?): Builder = apply { this.storageUri = storageUri }

        public fun build(): MarkUnarchiveCommand = MarkUnarchiveCommand(userId = userId, resourceId = resourceId, storageUri = storageUri)
    }

    public companion object {
        /** A builder of a `MarkUnarchiveCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
