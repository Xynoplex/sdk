// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.JobId

/** Payload for yield:created domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceCreatedPayload(
    public val name: String,
    public val format: ContentFormat,
    /** SHA-256 of content */
    public val contentChecksum: String,
    public val contentByteSize: Long? = null,
    public val entityTypes: kotlin.collections.List<String>? = null,
    /** The creating instruction's URI, recorded on the event. Append-only, so this value never changes — the LOCATION the projection serves is maintained across moves and lives on the resource's primary Representation, relocated by yield:moved. Optional: a resource may have no bytes. Working-tree URI, only file:// is supported (e.g. file://docs/overview.md). */
    public val storageUri: String? = null,
    public val language: String? = null,
    public val isDraft: Boolean? = null,
    /** The job this resource was made in fulfilment of, when its create cited one. A write that cites the same job on this resource, by the one who made it, is attributed to that job's requester: the `creator` here. */
    @get:JvmExposeBoxed
    public val jobId: JobId? = null,
    /** What this resource was generated from: the resource, and the annotation on it when the generation was for one. The resource's descriptor names the resource as `wasDerivedFrom`. */
    public val generatedFrom: ResourceCreatedPayloadGeneratedFrom? = null,
    public val generationPrompt: String? = null,
    public val generator: OneOrMoreAgents? = null,
    public val creator: Agent? = null,
    /** PROV-O wasAttributedTo, derived at write time from `creator` and the executor: both parties when they differ, one when they are the same. The value the resource view carries; readers do not re-derive it. */
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

        public fun contentByteSize(contentByteSize: Long?): Builder = apply { this.contentByteSize = contentByteSize }
        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun storageUri(storageUri: String?): Builder = apply { this.storageUri = storageUri }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun isDraft(isDraft: Boolean?): Builder = apply { this.isDraft = isDraft }

        @JvmExposeBoxed
        public fun jobId(jobId: JobId?): Builder = apply { this.jobId = jobId }

        public fun generatedFrom(generatedFrom: ResourceCreatedPayloadGeneratedFrom?): Builder = apply { this.generatedFrom = generatedFrom }
        public fun generationPrompt(generationPrompt: String?): Builder = apply { this.generationPrompt = generationPrompt }
        public fun generator(generator: OneOrMoreAgents?): Builder = apply { this.generator = generator }
        public fun creator(creator: Agent?): Builder = apply { this.creator = creator }
        public fun wasAttributedTo(wasAttributedTo: OneOrMoreAgents?): Builder = apply { this.wasAttributedTo = wasAttributedTo }

        public fun build(): ResourceCreatedPayload = ResourceCreatedPayload(name = name, format = format, contentChecksum = contentChecksum, contentByteSize = contentByteSize, entityTypes = entityTypes, storageUri = storageUri, language = language, isDraft = isDraft, jobId = jobId, generatedFrom = generatedFrom, generationPrompt = generationPrompt, generator = generator, creator = creator, wasAttributedTo = wasAttributedTo)
    }

    public companion object {
        /** A builder of a `ResourceCreatedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, format: ContentFormat, contentChecksum: String): Builder = Builder(name, format, contentChecksum)
    }
}
