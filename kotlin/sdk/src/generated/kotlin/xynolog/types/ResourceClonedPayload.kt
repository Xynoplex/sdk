// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Payload for yield:cloned domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceClonedPayload(
    public val name: String,
    public val format: ContentFormat,
    public val contentChecksum: String,
    public val contentByteSize: Long? = null,
    /** Where the clone's bytes are, on the resource's primary Representation — the same single home `yield:created` writes to. */
    public val storageUri: String? = null,
    @get:JvmExposeBoxed
    public val parentResourceId: ResourceId,
    public val entityTypes: kotlin.collections.List<String>? = null,
    public val language: String? = null,
    public val creator: Agent? = null,
    /** PROV-O wasAttributedTo, derived at write time: the cloner alone. The value the resource view carries. */
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

        public fun contentByteSize(contentByteSize: Long?): Builder = apply { this.contentByteSize = contentByteSize }
        public fun storageUri(storageUri: String?): Builder = apply { this.storageUri = storageUri }
        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun language(language: String?): Builder = apply { this.language = language }
        public fun creator(creator: Agent?): Builder = apply { this.creator = creator }
        public fun wasAttributedTo(wasAttributedTo: OneOrMoreAgents?): Builder = apply { this.wasAttributedTo = wasAttributedTo }

        public fun build(): ResourceClonedPayload = ResourceClonedPayload(name = name, format = format, contentChecksum = contentChecksum, contentByteSize = contentByteSize, storageUri = storageUri, parentResourceId = parentResourceId, entityTypes = entityTypes, language = language, creator = creator, wasAttributedTo = wasAttributedTo)
    }

    public companion object {
        /** A builder of a `ResourceClonedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(name: String, format: ContentFormat, contentChecksum: String, parentResourceId: ResourceId): Builder = Builder(name, format, contentChecksum, parentResourceId)
    }
}
