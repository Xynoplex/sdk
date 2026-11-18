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
 * The parameters of a `yield` job: what it is asked to make (GenerationJobRequest) and the gathered context it is made from. The job's resource is derived from `context.focus` by the dispatcher (resource focus → focus.resource; annotation focus → focus.sourceResource, with the worker binding to focus.annotation), and the dispatcher refuses a parameter this schema does not name.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GenerationJobParams(
    /**
     * Title of the generated resource. Not empty: the gateway refuses a `job:create` whose title is.
     */
    @SerialName("title")
    public val title: String,
    /**
     * Storage URI for the generated resource's content — AUTHORITATIVE: the worker writes exactly here and never derives a location from the title. Not empty, and there is no fallback: the gateway refuses a `job:create` whose storageUri is.
     */
    @SerialName("storageUri")
    public val storageUri: String,
    /**
     * Refining instruction, composed with `task` (task = what, prompt = how).
     */
    @SerialName("prompt")
    public val prompt: String? = null,
    /**
     * Entity-type tags to stamp on the synthesized resource. Used both as a prompt bias for the generation worker and as the `entityTypes` set on the resulting resource.
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    /**
     * Annotation/resource body locale — language the generated resource is written in (typically the user's UI locale). BCP-47.
     */
    @SerialName("language")
    public val language: String? = null,
    /**
     * Source-resource locale — language of the resource being referenced, used in the prompt so the LLM understands embedded source-context snippets when source ≠ target language. BCP-47.
     */
    @SerialName("sourceLanguage")
    public val sourceLanguage: String? = null,
    /**
     * Sampling temperature forwarded to the model.
     */
    @SerialName("temperature")
    public val temperature: Double? = null,
    /**
     * Output token budget forwarded to the model. Length never determines structure.
     */
    @SerialName("maxTokens")
    public val maxTokens: Double? = null,
    /**
     * Requested media type of the generated resource's content. Default `text/markdown` at the worker, which validates it against its supported output set and FAILS the job for anything it can't write — not a silent fallback.
     */
    @SerialName("outputMediaType")
    public val outputMediaType: SupportedMediaType? = null,
    /**
     * What the model is asked to produce — the prompt's framing verb. Canonical values ('resource', 'answer', 'summary') map to the worker's tested framings; any other string is used VERBATIM as the framing instruction (loud degrade: the worker warns, never silently falls back). Unset ⇒ 'resource' (article framing).
     */
    @SerialName("task")
    public val task: String? = null,
    /**
     * How the output is internally segmented — shape for text-bearing media, subordinate to `outputMediaType` (never its peer). Canonical values: 'prose' (flowing paragraphs), 'sections' (titled sections + title), 'chat' (speaker-labeled turns); any other string becomes a freeform "organize as: …" directive (loud degrade). Unset ⇒ NO structure directive at all — the task framing and the model determine shape.
     */
    @SerialName("structure")
    public val structure: String? = null,
    /**
     * Ask the model to cite its sources, by the ids the gathered context labels its passages with. The model wraps the words a source supports as `[[<id>: <claim>]]`, the ids of several sources separated by commas; a bare `[[<id>]]` is replaced by the source's name. The worker checks every id against the gathered context (an id it did not show is dropped, with a warning), takes every token out of the stored content, and mints a W3C linking annotation on the new resource over exactly the words each token cites.
     */
    @SerialName("cite")
    public val cite: Boolean? = null,
    /**
     * The gathered context that grounds the generation. Its `focus` names the anchor: the DISPATCHER derives the job's resourceId from it (resource focus → focus.resource; annotation focus → focus.sourceResource, with the worker auto-binding to focus.annotation) and REJECTS a caller-supplied id — the context is authoritative. Under `cite`, the ids its embedding carries are the only valid citation targets.
     */
    @SerialName("context")
    public val context: GatheredContext,
) {
    /** How Java makes a `GenerationJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val title: String,
        private val storageUri: String,
        private val context: GatheredContext,
    ) {
        private var prompt: String? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var language: String? = null
        private var sourceLanguage: String? = null
        private var temperature: Double? = null
        private var maxTokens: Double? = null
        private var outputMediaType: SupportedMediaType? = null
        private var task: String? = null
        private var structure: String? = null
        private var cite: Boolean? = null

        public fun prompt(prompt: String?): Builder {
            this.prompt = prompt
            return this
        }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder {
            this.entityTypes = entityTypes
            return this
        }

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun sourceLanguage(sourceLanguage: String?): Builder {
            this.sourceLanguage = sourceLanguage
            return this
        }

        public fun temperature(temperature: Double?): Builder {
            this.temperature = temperature
            return this
        }

        public fun maxTokens(maxTokens: Double?): Builder {
            this.maxTokens = maxTokens
            return this
        }

        public fun outputMediaType(outputMediaType: SupportedMediaType?): Builder {
            this.outputMediaType = outputMediaType
            return this
        }

        public fun task(task: String?): Builder {
            this.task = task
            return this
        }

        public fun structure(structure: String?): Builder {
            this.structure = structure
            return this
        }

        public fun cite(cite: Boolean?): Builder {
            this.cite = cite
            return this
        }

        public fun build(): GenerationJobParams = GenerationJobParams(title = title, storageUri = storageUri, prompt = prompt, entityTypes = entityTypes, language = language, sourceLanguage = sourceLanguage, temperature = temperature, maxTokens = maxTokens, outputMediaType = outputMediaType, task = task, structure = structure, cite = cite, context = context)
    }

    public companion object {
        /** A builder of a `GenerationJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(title: String, storageUri: String, context: GatheredContext): Builder = Builder(title, storageUri, context)
    }
}
