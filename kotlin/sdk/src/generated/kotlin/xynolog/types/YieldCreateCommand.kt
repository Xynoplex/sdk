// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId
import xynolog.identifiers.UserId

/** Bus command to create a yielded resource in the knowledge base. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldCreateCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /** The emitter's capabilities (the token's `roles`), injected by the /bus/emit gateway. Clients do not set this. An emitter carrying the worker role must cite the job this resource fulfils in `jobId`; the Stower refuses the create otherwise. */
    @SerialName("_roles")
    public val roles: kotlin.collections.List<String>? = null,
    /** The job this resource fulfils. Required when the emitter carries the worker role; absent for self-initiated work (a person, or an agent acting on its own). The knowledge base derives who requested this resource from the cited job's own events — the emitter never says who the work was for. */
    @get:JvmExposeBoxed
    public val jobId: JobId? = null,
    public val name: String,
    /** The caller's instruction for WHERE the bytes are — not a copy of the stored fact. The stored location lives on the resource's primary Representation (`Representation.storageUri`), which is its single home; this field is the message that puts it there. Working-tree URI, only file:// is supported (e.g. file://docs/overview.md). */
    public val storageUri: String,
    public val contentChecksum: String,
    public val byteSize: Long,
    public val format: ContentFormat,
    public val language: String? = null,
    public val entityTypes: kotlin.collections.List<String>? = null,
    public val isDraft: Boolean? = null,
    public val generatedFrom: YieldCreateCommandGeneratedFrom? = null,
    public val generationPrompt: String? = null,
    /** The Software peer that produced the content, when software did. Its identity must be the emitter's own — the knowledge base refuses a generator naming anyone else, and supplies it from the verified emitter when omitted. `creator` and `wasAttributedTo` are never sent; the knowledge base derives them from the emitter and the cited job. */
    public val generator: OneOrMoreAgents? = null,
) {
    /** How Java makes a `YieldCreateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val storageUri: String,
        private val contentChecksum: String,
        private val byteSize: Long,
        private val format: ContentFormat,
    ) {
        private var userId: UserId? = null
        private var roles: kotlin.collections.List<String>? = null
        private var jobId: JobId? = null
        private var language: String? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var isDraft: Boolean? = null
        private var generatedFrom: YieldCreateCommandGeneratedFrom? = null
        private var generationPrompt: String? = null
        private var generator: OneOrMoreAgents? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun roles(roles: kotlin.collections.List<String>?): Builder = apply { this.roles = roles }

        @JvmExposeBoxed
        public fun jobId(jobId: JobId?): Builder = apply { this.jobId = jobId }

        public fun language(language: String?): Builder = apply { this.language = language }
        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun isDraft(isDraft: Boolean?): Builder = apply { this.isDraft = isDraft }
        public fun generatedFrom(generatedFrom: YieldCreateCommandGeneratedFrom?): Builder = apply { this.generatedFrom = generatedFrom }
        public fun generationPrompt(generationPrompt: String?): Builder = apply { this.generationPrompt = generationPrompt }
        public fun generator(generator: OneOrMoreAgents?): Builder = apply { this.generator = generator }

        public fun build(): YieldCreateCommand = YieldCreateCommand(userId = userId, roles = roles, jobId = jobId, name = name, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize, format = format, language = language, entityTypes = entityTypes, isDraft = isDraft, generatedFrom = generatedFrom, generationPrompt = generationPrompt, generator = generator)
    }

    public companion object {
        /** A builder of a `YieldCreateCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, storageUri: String, contentChecksum: String, byteSize: Long, format: ContentFormat): Builder = Builder(name, storageUri, contentChecksum, byteSize, format)
    }
}
