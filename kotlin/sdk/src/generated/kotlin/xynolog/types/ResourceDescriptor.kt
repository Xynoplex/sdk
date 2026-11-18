// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.KeepGeneratedSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Metadata about a resource (1:1 with its URI). JSON-LD subject is @id. Link to concrete bytes via representations. */
@Serializable(with = ResourceDescriptor.Serializer::class)
@KeepGeneratedSerializer
public data class ResourceDescriptor(
    /** JSON-LD context; URI, object, or array of these. */
    @SerialName("@context")
    public val context: ResourceDescriptorContext,
    /** The id of the resource being described. */
    @SerialName("@id")
    @get:JvmExposeBoxed
    public val id: ResourceId,
    /** Type(s) of the resource (IRIs/CURIEs via @context). */
    @SerialName("@type")
    public val type: ResourceDescriptorType? = null,
    public val name: String,
    public val description: String? = null,
    /** Persistent identifiers (e.g., DOI, URN). */
    public val identifier: ResourceDescriptorIdentifier? = null,
    /** Topics (IRIs or strings). */
    public val about: ResourceDescriptorAbout? = null,
    /** Equivalent/authoritative references. */
    public val sameAs: kotlin.collections.List<String>? = null,
    public val isPartOf: kotlin.collections.List<String>? = null,
    public val hasPart: kotlin.collections.List<String>? = null,
    public val license: String? = null,
    public val version: String? = null,
    public val dateCreated: String? = null,
    public val dateModified: String? = null,
    /** W3C PROV: the resource, or resources, this one was derived from, each by its id */
    public val wasDerivedFrom: ResourceDescriptorWasDerivedFrom? = null,
    /** W3C PROV — every party responsible for this resource, derived by the knowledge base at creation from verified identities: `[requester, generator]` for a resource a job produced, collapsed to the one agent when the requester produced it. Never accepted from an emitter. */
    public val wasAttributedTo: ResourceDescriptorWasAttributedTo? = null,
    /** Software peer that produced this resource (W3C Web Annotation model). Its identity is the verified emitter of the create; the parameters are the producer's to state. */
    public val generator: ResourceDescriptorGenerator? = null,
    /** Profile/shape URI this resource description conforms to. */
    public val conformsTo: ResourceDescriptorConformsTo? = null,
    /** Convenience set summarizing media types across representations. */
    public val availableFormats: kotlin.collections.List<String>? = null,
    /** Managed or referenced byte-level renditions of this resource. */
    public val representations: ResourceDescriptorRepresentations,
    /** Application-specific: Whether this resource is archived */
    public val archived: Boolean? = null,
    /** Application-specific: Entity types for this resource */
    public val entityTypes: kotlin.collections.List<String>? = null,
    /** Application-specific: Whether this resource is a draft */
    public val isDraft: Boolean? = null,
    /** Application-specific: ID of annotation that triggered generation */
    @get:JvmExposeBoxed
    public val sourceAnnotationId: AnnotationId? = null,
    /** Application-specific: ID of source resource for clones/derivatives */
    @get:JvmExposeBoxed
    public val sourceResourceId: ResourceId? = null,
    /** Original URI from a source knowledge base when this resource was imported */
    public val originatedFrom: String? = null,
    /** Every property the schema does not name, as it came. */
    @Transient
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

        public fun type(type: ResourceDescriptorType?): Builder = apply { this.type = type }
        public fun description(description: String?): Builder = apply { this.description = description }
        public fun identifier(identifier: ResourceDescriptorIdentifier?): Builder = apply { this.identifier = identifier }
        public fun about(about: ResourceDescriptorAbout?): Builder = apply { this.about = about }
        public fun sameAs(sameAs: kotlin.collections.List<String>?): Builder = apply { this.sameAs = sameAs }
        public fun isPartOf(isPartOf: kotlin.collections.List<String>?): Builder = apply { this.isPartOf = isPartOf }
        public fun hasPart(hasPart: kotlin.collections.List<String>?): Builder = apply { this.hasPart = hasPart }
        public fun license(license: String?): Builder = apply { this.license = license }
        public fun version(version: String?): Builder = apply { this.version = version }
        public fun dateCreated(dateCreated: String?): Builder = apply { this.dateCreated = dateCreated }
        public fun dateModified(dateModified: String?): Builder = apply { this.dateModified = dateModified }
        public fun wasDerivedFrom(wasDerivedFrom: ResourceDescriptorWasDerivedFrom?): Builder = apply { this.wasDerivedFrom = wasDerivedFrom }
        public fun wasAttributedTo(wasAttributedTo: ResourceDescriptorWasAttributedTo?): Builder = apply { this.wasAttributedTo = wasAttributedTo }
        public fun generator(generator: ResourceDescriptorGenerator?): Builder = apply { this.generator = generator }
        public fun conformsTo(conformsTo: ResourceDescriptorConformsTo?): Builder = apply { this.conformsTo = conformsTo }
        public fun availableFormats(availableFormats: kotlin.collections.List<String>?): Builder = apply { this.availableFormats = availableFormats }
        public fun archived(archived: Boolean?): Builder = apply { this.archived = archived }
        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun isDraft(isDraft: Boolean?): Builder = apply { this.isDraft = isDraft }

        @JvmExposeBoxed
        public fun sourceAnnotationId(sourceAnnotationId: AnnotationId?): Builder = apply { this.sourceAnnotationId = sourceAnnotationId }

        @JvmExposeBoxed
        public fun sourceResourceId(sourceResourceId: ResourceId?): Builder = apply { this.sourceResourceId = sourceResourceId }

        public fun originatedFrom(originatedFrom: String?): Builder = apply { this.originatedFrom = originatedFrom }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): ResourceDescriptor = ResourceDescriptor(context = context, id = id, type = type, name = name, description = description, identifier = identifier, about = about, sameAs = sameAs, isPartOf = isPartOf, hasPart = hasPart, license = license, version = version, dateCreated = dateCreated, dateModified = dateModified, wasDerivedFrom = wasDerivedFrom, wasAttributedTo = wasAttributedTo, generator = generator, conformsTo = conformsTo, availableFormats = availableFormats, representations = representations, archived = archived, entityTypes = entityTypes, isDraft = isDraft, sourceAnnotationId = sourceAnnotationId, sourceResourceId = sourceResourceId, originatedFrom = originatedFrom, rest = rest)
    }

    public companion object {
        /** A builder of a `ResourceDescriptor` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(context: ResourceDescriptorContext, id: ResourceId, name: String, representations: ResourceDescriptorRepresentations): Builder = Builder(context, id, name, representations)
    }

    internal object Serializer : OpenObjectSerializer<ResourceDescriptor>(
        ResourceDescriptor.generatedSerializer(),
        ResourceDescriptor::rest,
        { named, rest -> named.copy(rest = rest) },
    )
}
