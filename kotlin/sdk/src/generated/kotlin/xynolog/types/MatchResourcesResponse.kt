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
 * One page of the resources a text search found, and which kind of answer it is.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MatchResourcesResponse(
    @SerialName("resources")
    public val resources: kotlin.collections.List<ResourceDescriptor>,
    /**
     * How many resources the search found in all, and not only on this page.
     */
    @SerialName("total")
    public val total: Long,
    /**
     * How many of the resources the search found were passed over before this page, as the request stated.
     */
    @SerialName("offset")
    public val offset: Long,
    /**
     * The limit the search was made with.
     */
    @SerialName("limit")
    public val limit: Long,
    /**
     * What kind of answer this is: 'lexical' — the resources matched the query text; 'semantic' — no lexical match existed, and these resources discuss the query per the vector index. Required so every producer labels its answer; a UI can render semantic results as a different kind of page ('no title matches, but these documents discuss it').
     */
    @SerialName("matchKind")
    public val matchKind: MatchResourcesResponseMatchKind,
) {
    /** How Java makes a `MatchResourcesResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resources: kotlin.collections.List<ResourceDescriptor>,
        private val total: Long,
        private val offset: Long,
        private val limit: Long,
        private val matchKind: MatchResourcesResponseMatchKind,
    ) {
        public fun build(): MatchResourcesResponse = MatchResourcesResponse(resources = resources, total = total, offset = offset, limit = limit, matchKind = matchKind)
    }

    public companion object {
        /** A builder of a `MatchResourcesResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resources: kotlin.collections.List<ResourceDescriptor>, total: Long, offset: Long, limit: Long, matchKind: MatchResourcesResponseMatchKind): Builder = Builder(resources, total, offset, limit, matchKind)
    }
}
