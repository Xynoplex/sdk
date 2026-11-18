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
 * Payload for yield:created domain event
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceCreatedPayload(
    @SerialName("name")
    public val name: String,
    @SerialName("format")
    public val format: ContentFormat,
    /**
     * SHA-256 of content
     */
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("contentByteSize")
    public val contentByteSize: Long? = null,
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    /**
     * The creating instruction's URI, recorded on the event. Append-only, so this value never changes — the LOCATION the projection serves is maintained across moves and lives on the resource's primary Representation, relocated by yield:moved. Optional: a resource may have no bytes. Working-tree URI, only file:// is supported (e.g. file://docs/overview.md).
     */
    @SerialName("storageUri")
    public val storageUri: String? = null,
    @SerialName("language")
    public val language: String? = null,
    @SerialName("isDraft")
    public val isDraft: Boolean? = null,
    /**
     * The job this resource was made in fulfilment of, when its create cited one. A write that cites the same job on this resource, by the one who made it, is attributed to that job's requester: the `creator` here.
     */
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId? = null,
    /**
     * What this resource was generated from: the resource, and the annotation on it when the generation was for one. The resource's descriptor names the resource as `wasDerivedFrom`.
     */
    @SerialName("generatedFrom")
    public val generatedFrom: ResourceCreatedPayloadGeneratedFrom? = null,
    @SerialName("generationPrompt")
    public val generationPrompt: String? = null,
    @SerialName("generator")
    public val generator: OneOrMoreAgents? = null,
    @SerialName("creator")
    public val creator: Agent? = null,
    /**
     * PROV-O wasAttributedTo, derived at write time from `creator` and the executor: both parties when they differ, one when they are the same. The value the resource view carries; readers do not re-derive it.
     */
    @SerialName("wasAttributedTo")
    public val wasAttributedTo: OneOrMoreAgents? = null,
) {
    /** How Java makes a `ResourceCreatedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val format: ContentFormat,
        private val contentChecksum: String,
    ) {
        private var contentByteSize: Long? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var storageUri: String? = null
        private var language: String? = null
        private var isDraft: Boolean? = null
        private var jobId: JobId? = null
        private var generatedFrom: ResourceCreatedPayloadGeneratedFrom? = null
        private var generationPrompt: String? = null
        private var generator: OneOrMoreAgents? = null
        private var creator: Agent? = null
        private var wasAttributedTo: OneOrMoreAgents? = null

        public fun contentByteSize(contentByteSize: Long?): Builder {
            this.contentByteSize = contentByteSize
            return this
        }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun storageUri(storageUri: String?): Builder {
            this.storageUri = storageUri
            return this
        }

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun isDraft(isDraft: Boolean?): Builder {
            this.isDraft = isDraft
            return this
        }

        @JvmExposeBoxed
        public fun jobId(jobId: JobId?): Builder {
            this.jobId = jobId
            return this
        }

        public fun generatedFrom(generatedFrom: ResourceCreatedPayloadGeneratedFrom?): Builder {
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

        public fun creator(creator: Agent?): Builder {
            this.creator = creator
            return this
        }

        public fun wasAttributedTo(wasAttributedTo: OneOrMoreAgents?): Builder {
            this.wasAttributedTo = wasAttributedTo
            return this
        }

        public fun build(): ResourceCreatedPayload = ResourceCreatedPayload(name = name, format = format, contentChecksum = contentChecksum, contentByteSize = contentByteSize, entityTypes = entityTypes, storageUri = storageUri, language = language, isDraft = isDraft, jobId = jobId, generatedFrom = generatedFrom, generationPrompt = generationPrompt, generator = generator, creator = creator, wasAttributedTo = wasAttributedTo)
    }

    public companion object {
        /** A builder of a `ResourceCreatedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, format: ContentFormat, contentChecksum: String): Builder = Builder(name, format, contentChecksum)
    }
}
