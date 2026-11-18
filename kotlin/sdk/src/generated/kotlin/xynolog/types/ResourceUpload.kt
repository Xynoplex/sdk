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
 * The multipart upload that creates a resource. A client sends it to the gateway's `POST /resources`; the gateway forwards it untouched to the Archivist's `POST /resources`, which stores the bytes and records the resource. One body, two hops.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceUpload(
    /**
     * Human-readable resource name
     */
    @SerialName("name")
    public val name: String,
    /**
     * Binary content
     */
    @SerialName("file")
    public val file: String,
    /**
     * Media type of the content (e.g. text/plain, text/markdown, image/png)
     */
    @SerialName("format")
    public val format: String,
    /**
     * Where the content lives (file://... for local). Required — the client names the location; the server does not derive one.
     */
    @SerialName("storageUri")
    public val storageUri: String,
    /**
     * ISO 639-1 language code
     */
    @SerialName("language")
    public val language: String? = null,
    /**
     * JSON-stringified array of entity type names
     */
    @SerialName("entityTypes")
    public val entityTypes: String? = null,
    /**
     * For AI-generated resources: the annotation that triggered generation. Nested into generatedFrom.annotationId on the persisted event.
     */
    @SerialName("sourceAnnotationId")
    @get:JvmExposeBoxed
    public val sourceAnnotationId: AnnotationId? = null,
    /**
     * For AI-generated resources: the source resource the generating annotation lives on. Nested into generatedFrom.resourceId on the persisted event.
     */
    @SerialName("sourceResourceId")
    @get:JvmExposeBoxed
    public val sourceResourceId: ResourceId? = null,
    /**
     * For AI-generated resources: the prompt that drove generation
     */
    @SerialName("generationPrompt")
    public val generationPrompt: String? = null,
    /**
     * For AI-generated resources: JSON-stringified Agent naming the model/worker that produced the content. Its identity must be the uploading agent's own — the knowledge base refuses a generator naming anyone else. `creator` and `wasAttributedTo` are never sent; the knowledge base derives them from the cited job.
     */
    @SerialName("generator")
    public val generator: String? = null,
    /**
     * The job this resource fulfils, when a worker is creating it. Forwarded onto yield:create; the knowledge base derives who requested the resource from the cited job's own events, and refuses a worker-role create that cites none. Absent for a person's own upload.
     */
    @SerialName("jobId")
    @get:JvmExposeBoxed
    public val jobId: JobId? = null,
    /**
     * 'true' or 'false' — whether the resource is a draft
     */
    @SerialName("isDraft")
    public val isDraft: String? = null,
    /**
     * A clone token from `yield:clone-token-requested`. With it, the resource is created as a clone of the token's source, inheriting its entity types; `language`, `entityTypes` and the generation fields are then not read.
     */
    @SerialName("cloneToken")
    public val cloneToken: String? = null,
    /**
     * With `cloneToken`: 'true' archives the source once the clone exists.
     */
    @SerialName("archiveOriginal")
    public val archiveOriginal: String? = null,
) {
    /** How Java makes a `ResourceUpload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val file: String,
        private val format: String,
        private val storageUri: String,
    ) {
        private var language: String? = null
        private var entityTypes: String? = null
        private var sourceAnnotationId: AnnotationId? = null
        private var sourceResourceId: ResourceId? = null
        private var generationPrompt: String? = null
        private var generator: String? = null
        private var jobId: JobId? = null
        private var isDraft: String? = null
        private var cloneToken: String? = null
        private var archiveOriginal: String? = null

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun entityTypes(entityTypes: String?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        @JvmExposeBoxed
        public fun sourceAnnotationId(sourceAnnotationId: AnnotationId?): Builder {
            this.sourceAnnotationId = sourceAnnotationId
            return this
        }

        @JvmExposeBoxed
        public fun sourceResourceId(sourceResourceId: ResourceId?): Builder {
            this.sourceResourceId = sourceResourceId
            return this
        }

        public fun generationPrompt(generationPrompt: String?): Builder {
            this.generationPrompt = generationPrompt
            return this
        }

        public fun generator(generator: String?): Builder {
            this.generator = generator
            return this
        }

        @JvmExposeBoxed
        public fun jobId(jobId: JobId?): Builder {
            this.jobId = jobId
            return this
        }

        public fun isDraft(isDraft: String?): Builder {
            this.isDraft = isDraft
            return this
        }

        public fun cloneToken(cloneToken: String?): Builder {
            this.cloneToken = cloneToken
            return this
        }

        public fun archiveOriginal(archiveOriginal: String?): Builder {
            this.archiveOriginal = archiveOriginal
            return this
        }

        public fun build(): ResourceUpload = ResourceUpload(name = name, file = file, format = format, storageUri = storageUri, language = language, entityTypes = entityTypes, sourceAnnotationId = sourceAnnotationId, sourceResourceId = sourceResourceId, generationPrompt = generationPrompt, generator = generator, jobId = jobId, isDraft = isDraft, cloneToken = cloneToken, archiveOriginal = archiveOriginal)
    }

    public companion object {
        /** A builder of a `ResourceUpload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, file: String, format: String, storageUri: String): Builder = Builder(name, file, format, storageUri)
    }
}
