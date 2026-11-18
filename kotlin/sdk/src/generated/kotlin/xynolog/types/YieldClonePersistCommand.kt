// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * Command: stow an already-uploaded clone's bytes and append `yield:cloned`.
 *
 * The INNER half of the clone flow. `yield:clone-create` reaches the CloneTokenManager, which alone can validate the token and read the source's entity types; it then emits this so the Stower — the only appendEvent caller — writes the domain event.
 *
 * Distinct from `yield:create` because a clone is a distinct operation, not a creation with an extra field. It REQUIRES a parent, and that requirement is what a separate command expresses: an optional `parentResourceId` on the create command could not say that a clone without a parent is not a clone. `ResourceClonedPayload` requires it for the same reason.
 *
 * Generated resources are NOT clones: they carry provenance in `generatedFrom` and stay on `yield:create`.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldClonePersistCommand(
    /** Injected by the gateway from the authenticated principal; never supplied by a wire caller. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    public val name: String,
    /** The caller's instruction for WHERE the bytes are — the uploader wrote them before emitting this. The stored location lives on the clone's primary Representation, the one home of a storage URI. */
    public val storageUri: String,
    public val contentChecksum: String,
    public val byteSize: Long,
    public val format: ContentFormat,
    public val language: String? = null,
    /** Inherited from the source resource by the CloneTokenManager, which is the only party that knows the token is valid. */
    public val entityTypes: kotlin.collections.List<String>? = null,
    /** The resource this one is cloned FROM. Required: it is what makes this a clone rather than a creation. */
    @get:JvmExposeBoxed
    public val parentResourceId: ResourceId,
) {
    /** How Java makes a `YieldClonePersistCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val storageUri: String,
        private val contentChecksum: String,
        private val byteSize: Long,
        private val format: ContentFormat,
        private val parentResourceId: ResourceId,
    ) {
        private var userId: UserId? = null
        private var language: String? = null
        private var entityTypes: kotlin.collections.List<String>? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun language(language: String?): Builder = apply { this.language = language }
        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }

        public fun build(): YieldClonePersistCommand = YieldClonePersistCommand(userId = userId, name = name, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize, format = format, language = language, entityTypes = entityTypes, parentResourceId = parentResourceId)
    }

    public companion object {
        /** A builder of a `YieldClonePersistCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(name: String, storageUri: String, contentChecksum: String, byteSize: Long, format: ContentFormat, parentResourceId: ResourceId): Builder = Builder(name, storageUri, contentChecksum, byteSize, format, parentResourceId)
    }
}
