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
 * Payload for yield:cloned domain event
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceClonedPayload(
    @SerialName("name")
    public val name: String,
    @SerialName("format")
    public val format: ContentFormat,
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("contentByteSize")
    public val contentByteSize: Long? = null,
    /**
     * Where the clone's bytes are, on the resource's primary Representation — the same single home `yield:created` writes to.
     */
    @SerialName("storageUri")
    public val storageUri: String? = null,
    @SerialName("parentResourceId")
    @get:JvmExposeBoxed
    public val parentResourceId: ResourceId,
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>? = null,
    @SerialName("language")
    public val language: String? = null,
    @SerialName("creator")
    public val creator: Agent? = null,
    /**
     * PROV-O wasAttributedTo, derived at write time: the cloner alone. The value the resource view carries.
     */
    @SerialName("wasAttributedTo")
    public val wasAttributedTo: OneOrMoreAgents? = null,
) {
    /** How Java makes a `ResourceClonedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val format: ContentFormat,
        private val contentChecksum: String,
        private val parentResourceId: ResourceId,
    ) {
        private var contentByteSize: Long? = null
        private var storageUri: String? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var language: String? = null
        private var creator: Agent? = null
        private var wasAttributedTo: OneOrMoreAgents? = null

        public fun contentByteSize(contentByteSize: Long?): Builder {
            this.contentByteSize = contentByteSize
            return this
        }

        public fun storageUri(storageUri: String?): Builder {
            this.storageUri = storageUri
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

        public fun creator(creator: Agent?): Builder {
            this.creator = creator
            return this
        }

        public fun wasAttributedTo(wasAttributedTo: OneOrMoreAgents?): Builder {
            this.wasAttributedTo = wasAttributedTo
            return this
        }

        public fun build(): ResourceClonedPayload = ResourceClonedPayload(name = name, format = format, contentChecksum = contentChecksum, contentByteSize = contentByteSize, storageUri = storageUri, parentResourceId = parentResourceId, entityTypes = entityTypes, language = language, creator = creator, wasAttributedTo = wasAttributedTo)
    }

    public companion object {
        /** A builder of a `ResourceClonedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(name: String, format: ContentFormat, contentChecksum: String, parentResourceId: ResourceId): Builder = Builder(name, format, contentChecksum, parentResourceId)
    }
}
