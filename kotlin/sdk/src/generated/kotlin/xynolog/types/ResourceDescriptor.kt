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
 * Metadata about a resource (1:1 with its URI). JSON-LD subject is @id. Link to concrete bytes via representations.
 */
@Serializable(with = ResourceDescriptor.Serializer::class)
public data class ResourceDescriptor(
    /**
     * JSON-LD context; URI, object, or array of these.
     */
    @SerialName("@context")
    public val context: ResourceDescriptorContext,
    /**
     * The id of the resource being described.
     */
    @SerialName("@id")
    @get:JvmExposeBoxed
    public val id: ResourceId,
    /**
     * Type(s) of the resource (IRIs/CURIEs via @context).
     */
    @SerialName("@type")
    public val type: ResourceDescriptorType? = null,
    @SerialName("name")
    public val name: String,
    @SerialName("description")
    public val description: String? = null,
    /**
     * Persistent identifiers (e.g., DOI, URN).
     */
    @SerialName("identifier")
    public val identifier: ResourceDescriptorIdentifier? = null,
    /**
     * Topics (IRIs or strings).
     */
    @SerialName("about")
    public val about: ResourceDescriptorAbout? = null,
    /**
     * Equivalent/authoritative references.
     */
    @SerialName("sameAs")
    public val sameAs: kotlin.collections.List<String>? = null,
    @SerialName("isPartOf")
    public val isPartOf: kotlin.collections.List<String>? = null,
    @SerialName("hasPart")
    public val hasPart: kotlin.collections.List<String>? = null,
    @SerialName("license")
    public val license: String? = null,
    @SerialName("version")
    public val version: String? = null,
    @SerialName("dateCreated")
    public val dateCreated: String? = null,
    @SerialName("dateModified")
    public val dateModified: String? = null,
    /**
     * W3C PROV: the resource, or resources, this one was derived from, each by its id
     */
    @SerialName("wasDerivedFrom")
    public val wasDerivedFrom: ResourceDescriptorWasDerivedFrom? = null,
    /**
     * W3C PROV — every party responsible for this resource, derived by the knowledge base at creation from verified identities: `[requester, generator]` for a resource a job produced, collapsed to the one agent when the requester produced it. Never accepted from an emitter.
     */
    @SerialName("wasAttributedTo")
    public val wasAttributedTo: ResourceDescriptorWasAttributedTo? = null,
    /**
     * Software peer that produced this resource (W3C Web Annotation model). Its identity is the verified emitter of the create; the parameters are the producer's to state.
     */
    @SerialName("generator")
    public val generator: ResourceDescriptorGenerator? = null,
    /**
     * Profile/shape URI this resource description conforms to.
     */
    @SerialName("conformsTo")
    public val conformsTo: ResourceDescriptorConformsTo? = null,
    /**
     * Convenience set summarizing media types across representations.
     */
    @SerialName("availableFormats")
    public val availableFormats: kotlin.collections.List<String>? = null,
    /**
     * Managed or referenced byte-level renditions of this resource.
     */
    @SerialName("representations")
    public val representations: ResourceDescriptorRepresentations,
    /**
     * Application-specific: Whether this resource is archived
     */
    @SerialName("archived")
    public val archived: Boolean? = null,
    /**
     * Application-specific: Entity types for this resource
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    /**
     * Application-specific: Whether this resource is a draft
     */
    @SerialName("isDraft")
    public val isDraft: Boolean? = null,
    /**
     * Application-specific: ID of annotation that triggered generation
     */
    @SerialName("sourceAnnotationId")
    @get:JvmExposeBoxed
    public val sourceAnnotationId: AnnotationId? = null,
    /**
     * Application-specific: ID of source resource for clones/derivatives
     */
    @SerialName("sourceResourceId")
    @get:JvmExposeBoxed
    public val sourceResourceId: ResourceId? = null,
    /**
     * Original URI from a source knowledge base when this resource was imported
     */
    @SerialName("originatedFrom")
    public val originatedFrom: String? = null,
    /** Every property the schema does not name, as it came. */
    public val rest: JsonObject = JsonObject(emptyMap()),
) {
    /** How Java makes a `ResourceDescriptor`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val context: ResourceDescriptorContext,
        private val id: ResourceId,
        private val name: String,
        private val representations: ResourceDescriptorRepresentations,
    ) {
        private var type: ResourceDescriptorType? = null
        private var description: String? = null
        private var identifier: ResourceDescriptorIdentifier? = null
        private var about: ResourceDescriptorAbout? = null
        private var sameAs: kotlin.collections.List<String>? = null
        private var isPartOf: kotlin.collections.List<String>? = null
        private var hasPart: kotlin.collections.List<String>? = null
        private var license: String? = null
        private var version: String? = null
        private var dateCreated: String? = null
        private var dateModified: String? = null
        private var wasDerivedFrom: ResourceDescriptorWasDerivedFrom? = null
        private var wasAttributedTo: ResourceDescriptorWasAttributedTo? = null
        private var generator: ResourceDescriptorGenerator? = null
        private var conformsTo: ResourceDescriptorConformsTo? = null
        private var availableFormats: kotlin.collections.List<String>? = null
        private var archived: Boolean? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var isDraft: Boolean? = null
        private var sourceAnnotationId: AnnotationId? = null
        private var sourceResourceId: ResourceId? = null
        private var originatedFrom: String? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun type(type: ResourceDescriptorType?): Builder {
            this.type = type
            return this
        }

        public fun description(description: String?): Builder {
            this.description = description
            return this
        }

        public fun identifier(identifier: ResourceDescriptorIdentifier?): Builder {
            this.identifier = identifier
            return this
        }

        public fun about(about: ResourceDescriptorAbout?): Builder {
            this.about = about
            return this
        }

        public fun sameAs(sameAs: kotlin.collections.List<String>?): Builder {
            this.sameAs = sameAs
            return this
        }

        public fun isPartOf(isPartOf: kotlin.collections.List<String>?): Builder {
            this.isPartOf = isPartOf
            return this
        }

        public fun hasPart(hasPart: kotlin.collections.List<String>?): Builder {
            this.hasPart = hasPart
            return this
        }

        public fun license(license: String?): Builder {
            this.license = license
            return this
        }

        public fun version(version: String?): Builder {
            this.version = version
            return this
        }

        public fun dateCreated(dateCreated: String?): Builder {
            this.dateCreated = dateCreated
            return this
        }

        public fun dateModified(dateModified: String?): Builder {
            this.dateModified = dateModified
            return this
        }

        public fun wasDerivedFrom(wasDerivedFrom: ResourceDescriptorWasDerivedFrom?): Builder {
            this.wasDerivedFrom = wasDerivedFrom
            return this
        }

        public fun wasAttributedTo(wasAttributedTo: ResourceDescriptorWasAttributedTo?): Builder {
            this.wasAttributedTo = wasAttributedTo
            return this
        }

        public fun generator(generator: ResourceDescriptorGenerator?): Builder {
            this.generator = generator
            return this
        }

        public fun conformsTo(conformsTo: ResourceDescriptorConformsTo?): Builder {
            this.conformsTo = conformsTo
            return this
        }

        public fun availableFormats(availableFormats: kotlin.collections.List<String>?): Builder {
            this.availableFormats = availableFormats
            return this
        }

        public fun archived(archived: Boolean?): Builder {
            this.archived = archived
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

        public fun originatedFrom(originatedFrom: String?): Builder {
            this.originatedFrom = originatedFrom
            return this
        }

        public fun rest(rest: JsonObject): Builder {
            this.rest = rest
            return this
        }

        public fun build(): ResourceDescriptor = ResourceDescriptor(context = context, id = id, type = type, name = name, description = description, identifier = identifier, about = about, sameAs = sameAs, isPartOf = isPartOf, hasPart = hasPart, license = license, version = version, dateCreated = dateCreated, dateModified = dateModified, wasDerivedFrom = wasDerivedFrom, wasAttributedTo = wasAttributedTo, generator = generator, conformsTo = conformsTo, availableFormats = availableFormats, representations = representations, archived = archived, entityTypes = entityTypes, isDraft = isDraft, sourceAnnotationId = sourceAnnotationId, sourceResourceId = sourceResourceId, originatedFrom = originatedFrom, rest = rest)
    }

    public companion object {
        /** A builder of a `ResourceDescriptor` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(context: ResourceDescriptorContext, id: ResourceId, name: String, representations: ResourceDescriptorRepresentations): Builder = Builder(context, id, name, representations)
    }

    @Serializable
    internal data class Known(
        /**
         * JSON-LD context; URI, object, or array of these.
         */
        @SerialName("@context")
        public val context: ResourceDescriptorContext,
        /**
         * The id of the resource being described.
         */
        @SerialName("@id")
        public val id: ResourceId,
        /**
         * Type(s) of the resource (IRIs/CURIEs via @context).
         */
        @SerialName("@type")
        public val type: ResourceDescriptorType? = null,
        @SerialName("name")
        public val name: String,
        @SerialName("description")
        public val description: String? = null,
        /**
         * Persistent identifiers (e.g., DOI, URN).
         */
        @SerialName("identifier")
        public val identifier: ResourceDescriptorIdentifier? = null,
        /**
         * Topics (IRIs or strings).
         */
        @SerialName("about")
        public val about: ResourceDescriptorAbout? = null,
        /**
         * Equivalent/authoritative references.
         */
        @SerialName("sameAs")
        public val sameAs: kotlin.collections.List<String>? = null,
        @SerialName("isPartOf")
        public val isPartOf: kotlin.collections.List<String>? = null,
        @SerialName("hasPart")
        public val hasPart: kotlin.collections.List<String>? = null,
        @SerialName("license")
        public val license: String? = null,
        @SerialName("version")
        public val version: String? = null,
        @SerialName("dateCreated")
        public val dateCreated: String? = null,
        @SerialName("dateModified")
        public val dateModified: String? = null,
        /**
         * W3C PROV: the resource, or resources, this one was derived from, each by its id
         */
        @SerialName("wasDerivedFrom")
        public val wasDerivedFrom: ResourceDescriptorWasDerivedFrom? = null,
        /**
         * W3C PROV — every party responsible for this resource, derived by the knowledge base at creation from verified identities: `[requester, generator]` for a resource a job produced, collapsed to the one agent when the requester produced it. Never accepted from an emitter.
         */
        @SerialName("wasAttributedTo")
        public val wasAttributedTo: ResourceDescriptorWasAttributedTo? = null,
        /**
         * Software peer that produced this resource (W3C Web Annotation model). Its identity is the verified emitter of the create; the parameters are the producer's to state.
         */
        @SerialName("generator")
        public val generator: ResourceDescriptorGenerator? = null,
        /**
         * Profile/shape URI this resource description conforms to.
         */
        @SerialName("conformsTo")
        public val conformsTo: ResourceDescriptorConformsTo? = null,
        /**
         * Convenience set summarizing media types across representations.
         */
        @SerialName("availableFormats")
        public val availableFormats: kotlin.collections.List<String>? = null,
        /**
         * Managed or referenced byte-level renditions of this resource.
         */
        @SerialName("representations")
        public val representations: ResourceDescriptorRepresentations,
        /**
         * Application-specific: Whether this resource is archived
         */
        @SerialName("archived")
        public val archived: Boolean? = null,
        /**
         * Application-specific: Entity types for this resource
         */
        @SerialName("entityTypes")
        public val entityTypes: kotlin.collections.List<String>? = null,
        /**
         * Application-specific: Whether this resource is a draft
         */
        @SerialName("isDraft")
        public val isDraft: Boolean? = null,
        /**
         * Application-specific: ID of annotation that triggered generation
         */
        @SerialName("sourceAnnotationId")
        public val sourceAnnotationId: AnnotationId? = null,
        /**
         * Application-specific: ID of source resource for clones/derivatives
         */
        @SerialName("sourceResourceId")
        public val sourceResourceId: ResourceId? = null,
        /**
         * Original URI from a source knowledge base when this resource was imported
         */
        @SerialName("originatedFrom")
        public val originatedFrom: String? = null,
    )

    internal object Serializer : KSerializer<ResourceDescriptor> {
        private val named: Set<String> = setOf("@context", "@id", "@type", "name", "description", "identifier", "about", "sameAs", "isPartOf", "hasPart", "license", "version", "dateCreated", "dateModified", "wasDerivedFrom", "wasAttributedTo", "generator", "conformsTo", "availableFormats", "representations", "archived", "entityTypes", "isDraft", "sourceAnnotationId", "sourceResourceId", "originatedFrom")

        override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.ResourceDescriptor", Known.serializer().descriptor)

        override fun deserialize(decoder: Decoder): ResourceDescriptor {
            val json = decoder as? JsonDecoder ?: throw SerializationException("a ResourceDescriptor is read from JSON alone")
            val all = json.decodeJsonElement().jsonObject
            val known = json.json.decodeFromJsonElement(Known.serializer(), JsonObject(all.filterKeys { it in named }))
            return ResourceDescriptor(context = known.context, id = known.id, type = known.type, name = known.name, description = known.description, identifier = known.identifier, about = known.about, sameAs = known.sameAs, isPartOf = known.isPartOf, hasPart = known.hasPart, license = known.license, version = known.version, dateCreated = known.dateCreated, dateModified = known.dateModified, wasDerivedFrom = known.wasDerivedFrom, wasAttributedTo = known.wasAttributedTo, generator = known.generator, conformsTo = known.conformsTo, availableFormats = known.availableFormats, representations = known.representations, archived = known.archived, entityTypes = known.entityTypes, isDraft = known.isDraft, sourceAnnotationId = known.sourceAnnotationId, sourceResourceId = known.sourceResourceId, originatedFrom = known.originatedFrom, rest = JsonObject(all.filterKeys { it !in named }))
        }

        override fun serialize(encoder: Encoder, value: ResourceDescriptor) {
            val json = encoder as? JsonEncoder ?: throw SerializationException("a ResourceDescriptor is written as JSON alone")
            val known = json.json.encodeToJsonElement(Known.serializer(), Known(context = value.context, id = value.id, type = value.type, name = value.name, description = value.description, identifier = value.identifier, about = value.about, sameAs = value.sameAs, isPartOf = value.isPartOf, hasPart = value.hasPart, license = value.license, version = value.version, dateCreated = value.dateCreated, dateModified = value.dateModified, wasDerivedFrom = value.wasDerivedFrom, wasAttributedTo = value.wasAttributedTo, generator = value.generator, conformsTo = value.conformsTo, availableFormats = value.availableFormats, representations = value.representations, archived = value.archived, entityTypes = value.entityTypes, isDraft = value.isDraft, sourceAnnotationId = value.sourceAnnotationId, sourceResourceId = value.sourceResourceId, originatedFrom = value.originatedFrom)).jsonObject
            json.encodeJsonElement(JsonObject(known + value.rest))
        }
    }
}
