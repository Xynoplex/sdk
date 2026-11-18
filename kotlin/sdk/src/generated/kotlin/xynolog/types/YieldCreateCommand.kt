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

/**
 * Bus command to create a yielded resource in the knowledge base.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldCreateCommand(
    /**
     * Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this.
     */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /**
     * The emitter's capabilities (the token's `roles`), injected by the /bus/emit gateway. Clients do not set this. An emitter carrying the worker role must cite the job this resource fulfils in `jobId`; the Stower refuses the create otherwise.
     */
    @SerialName("_roles")
    public val roles: kotlin.collections.List<String>? = null,
    /**
     * The job this resource fulfils. Required when the emitter carries the worker role; absent for self-initiated work (a person, or an agent acting on its own). The knowledge base derives who requested this resource from the cited job's own events — the emitter never says who the work was for.
     */
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId? = null,
    @SerialName("name")
    public val name: String,
    /**
     * The caller's instruction for WHERE the bytes are — not a copy of the stored fact. The stored location lives on the resource's primary Representation (`Representation.storageUri`), which is its single home; this field is the message that puts it there. Working-tree URI, only file:// is supported (e.g. file://docs/overview.md).
     */
    @SerialName("storageUri")
    public val storageUri: String,
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("byteSize")
    public val byteSize: Long,
    @SerialName("format")
    public val format: ContentFormat,
    @SerialName("language")
    public val language: String? = null,
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    @SerialName("isDraft")
    public val isDraft: Boolean? = null,
    @SerialName("generatedFrom")
    public val generatedFrom: YieldCreateCommandGeneratedFrom? = null,
    @SerialName("generationPrompt")
    public val generationPrompt: String? = null,
    /**
     * The Software peer that produced the content, when software did. Its identity must be the emitter's own — the knowledge base refuses a generator naming anyone else, and supplies it from the verified emitter when omitted. `creator` and `wasAttributedTo` are never sent; the knowledge base derives them from the emitter and the cited job.
     */
    @SerialName("generator")
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
        public fun userId(userId: UserId?): Builder {
            this.userId = userId
            return this
        }

        public fun roles(roles: kotlin.collections.List<String>?): Builder {
            this.roles = roles
            return this
        }

        @JvmExposeBoxed
        public fun jobId(jobId: JobId?): Builder {
            this.jobId = jobId
            return this
        }

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun isDraft(isDraft: Boolean?): Builder {
            this.isDraft = isDraft
            return this
        }

        public fun generatedFrom(generatedFrom: YieldCreateCommandGeneratedFrom?): Builder {
            this.generatedFrom = generatedFrom
            return this
        }

        public fun generationPrompt(generationPrompt: String?): Builder {
            this.generationPrompt = generationPrompt
            return this
        }

        public fun generator(generator: OneOrMoreAgents?): Builder {
            this.generator = generator
            return this
        }

        public fun build(): YieldCreateCommand = YieldCreateCommand(userId = userId, roles = roles, jobId = jobId, name = name, storageUri = storageUri, contentChecksum = contentChecksum, byteSize = byteSize, format = format, language = language, entityTypes = entityTypes, isDraft = isDraft, generatedFrom = generatedFrom, generationPrompt = generationPrompt, generator = generator)
    }

    public companion object {
        /** A builder of a `YieldCreateCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, storageUri: String, contentChecksum: String, byteSize: Long, format: ContentFormat): Builder = Builder(name, storageUri, contentChecksum, byteSize, format)
    }
}
