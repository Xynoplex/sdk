// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonObject

/** A specific, byte-addressable rendition of a resource (file/asset/variant). */
@Serializable(with = Representation.Serializer::class)
public data class Representation(
    /** Stable ID for this representation. */
    @SerialName("@id")
    public val id: String? = null,
    /** Type(s), e.g., schema:MediaObject. */
    @SerialName("@type")
    public val type: RepresentationType? = null,
    /** MIME/media type (e.g., text/markdown, image/png). */
    public val mediaType: String,
    /** Working-tree URI identifying where this rendition's bytes live. Only file:// is supported (e.g. file://docs/overview.md). The single home of the storage location: maintained across moves (yield:moved relocates it), absent when the resource has no stored bytes. */
    public val storageUri: String? = null,
    public val filename: String? = null,
    /** Size of the payload in bytes. */
    public val byteSize: Long? = null,
    /** The SHA-256 of the bytes, as 64 lower-case hexadecimal digits with nothing before them. Whatever compares the checksums of two representations compares this text. */
    public val checksum: String? = null,
    /** Compression/transfer encoding if applicable. */
    public val encoding: String? = null,
    /** IETF BCP 47 language tag (e.g., en, es-ES). */
    public val language: String? = null,
    /** Pixels (images/video). */
    public val width: Long? = null,
    /** Pixels (images/video). */
    public val height: Long? = null,
    /** Seconds (audio/video). */
    public val duration: Double? = null,
    public val created: String? = null,
    public val modified: String? = null,
    /** Profile/shape the bytes conform to (e.g., a JSON profile or SVG profile). */
    public val conformsTo: RepresentationConformsTo? = null,
    public val tags: kotlin.collections.List<String>? = null,
    /** Semantics of this rendition relative to the resource (e.g., original, thumbnail, preview, derived). */
    public val rel: RepresentationRel? = null,
    /** Every property the schema does not name, as it came. */
    public val rest: JsonObject = JsonObject(emptyMap()),
) : ResourceDescriptorRepresentations,
    ScoredResourceRepresentations {
    /** How Java makes a `Representation`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val mediaType: String,
    ) {
        private var id: String? = null
        private var type: RepresentationType? = null
        private var storageUri: String? = null
        private var filename: String? = null
        private var byteSize: Long? = null
        private var checksum: String? = null
        private var encoding: String? = null
        private var language: String? = null
        private var width: Long? = null
        private var height: Long? = null
        private var duration: Double? = null
        private var created: String? = null
        private var modified: String? = null
        private var conformsTo: RepresentationConformsTo? = null
        private var tags: kotlin.collections.List<String>? = null
        private var rel: RepresentationRel? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun id(id: String?): Builder = apply { this.id = id }
        public fun type(type: RepresentationType?): Builder = apply { this.type = type }
        public fun storageUri(storageUri: String?): Builder = apply { this.storageUri = storageUri }
        public fun filename(filename: String?): Builder = apply { this.filename = filename }
        public fun byteSize(byteSize: Long?): Builder = apply { this.byteSize = byteSize }
        public fun checksum(checksum: String?): Builder = apply { this.checksum = checksum }
        public fun encoding(encoding: String?): Builder = apply { this.encoding = encoding }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun width(width: Long?): Builder = apply { this.width = width }
        public fun height(height: Long?): Builder = apply { this.height = height }
        public fun duration(duration: Double?): Builder = apply { this.duration = duration }
        public fun created(created: String?): Builder = apply { this.created = created }
        public fun modified(modified: String?): Builder = apply { this.modified = modified }
        public fun conformsTo(conformsTo: RepresentationConformsTo?): Builder = apply { this.conformsTo = conformsTo }
        public fun tags(tags: kotlin.collections.List<String>?): Builder = apply { this.tags = tags }
        public fun rel(rel: RepresentationRel?): Builder = apply { this.rel = rel }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): Representation = Representation(id = id, type = type, mediaType = mediaType, storageUri = storageUri, filename = filename, byteSize = byteSize, checksum = checksum, encoding = encoding, language = language, width = width, height = height, duration = duration, created = created, modified = modified, conformsTo = conformsTo, tags = tags, rel = rel, rest = rest)
    }

    public companion object {
        /** A builder of a `Representation` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(mediaType: String): Builder = Builder(mediaType)
    }

    @Serializable
    internal data class Known(
        /** Stable ID for this representation. */
        @SerialName("@id")
        public val id: String? = null,
        /** Type(s), e.g., schema:MediaObject. */
        @SerialName("@type")
        public val type: RepresentationType? = null,
        /** MIME/media type (e.g., text/markdown, image/png). */
        public val mediaType: String,
        /** Working-tree URI identifying where this rendition's bytes live. Only file:// is supported (e.g. file://docs/overview.md). The single home of the storage location: maintained across moves (yield:moved relocates it), absent when the resource has no stored bytes. */
        public val storageUri: String? = null,
        public val filename: String? = null,
        /** Size of the payload in bytes. */
        public val byteSize: Long? = null,
        /** The SHA-256 of the bytes, as 64 lower-case hexadecimal digits with nothing before them. Whatever compares the checksums of two representations compares this text. */
        public val checksum: String? = null,
        /** Compression/transfer encoding if applicable. */
        public val encoding: String? = null,
        /** IETF BCP 47 language tag (e.g., en, es-ES). */
        public val language: String? = null,
        /** Pixels (images/video). */
        public val width: Long? = null,
        /** Pixels (images/video). */
        public val height: Long? = null,
        /** Seconds (audio/video). */
        public val duration: Double? = null,
        public val created: String? = null,
        public val modified: String? = null,
        /** Profile/shape the bytes conform to (e.g., a JSON profile or SVG profile). */
        public val conformsTo: RepresentationConformsTo? = null,
        public val tags: kotlin.collections.List<String>? = null,
        /** Semantics of this rendition relative to the resource (e.g., original, thumbnail, preview, derived). */
        public val rel: RepresentationRel? = null,
    )

    internal object Serializer : KSerializer<Representation> {
        private val named: Set<String> = setOf("@id", "@type", "mediaType", "storageUri", "filename", "byteSize", "checksum", "encoding", "language", "width", "height", "duration", "created", "modified", "conformsTo", "tags", "rel")

        override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.Representation", Known.serializer().descriptor)

        override fun deserialize(decoder: Decoder): Representation {
            val json = decoder as? JsonDecoder ?: throw SerializationException("a Representation is read from JSON alone")
            val all = json.decodeJsonElement().jsonObject
            val known = json.json.decodeFromJsonElement(Known.serializer(), JsonObject(all.filterKeys { it in named }))
            return Representation(id = known.id, type = known.type, mediaType = known.mediaType, storageUri = known.storageUri, filename = known.filename, byteSize = known.byteSize, checksum = known.checksum, encoding = known.encoding, language = known.language, width = known.width, height = known.height, duration = known.duration, created = known.created, modified = known.modified, conformsTo = known.conformsTo, tags = known.tags, rel = known.rel, rest = JsonObject(all.filterKeys { it !in named }))
        }

        override fun serialize(encoder: Encoder, value: Representation) {
            val json = encoder as? JsonEncoder ?: throw SerializationException("a Representation is written as JSON alone")
            val known = json.json.encodeToJsonElement(Known.serializer(), Known(id = value.id, type = value.type, mediaType = value.mediaType, storageUri = value.storageUri, filename = value.filename, byteSize = value.byteSize, checksum = value.checksum, encoding = value.encoding, language = value.language, width = value.width, height = value.height, duration = value.duration, created = value.created, modified = value.modified, conformsTo = value.conformsTo, tags = value.tags, rel = value.rel)).jsonObject
            json.encodeJsonElement(JsonObject(known + value.rest))
        }
    }
}
