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
 * Request payload sent on the match:search-request bus channel to find candidate matches.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class MatchSearchRequest(
    /**
     * Resource ID the reference annotation belongs to. Used to scope result events on the EventBus so the events-stream delivers them to participants viewing this resource.
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * Annotation ID of the reference to search candidates for
     */
    @SerialName("referenceId")
    @get:JvmExposeBoxed
    public val referenceId: AnnotationId,
    /**
     * Gathered context for the reference annotation
     */
    @SerialName("context")
    public val context: GatheredContext,
    /**
     * Maximum number of candidate results to return
     */
    @SerialName("limit")
    public val limit: Long? = null,
    /**
     * Enable semantic similarity scoring in addition to keyword matching
     */
    @SerialName("useSemanticScoring")
    public val useSemanticScoring: Boolean? = null,
) {
    /** How Java makes a `MatchSearchRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val referenceId: AnnotationId,
        private val context: GatheredContext,
    ) {
        private var limit: Long? = null
        private var useSemanticScoring: Boolean? = null

        public fun limit(limit: Long?): Builder {
            this.limit = limit
            return this
        }

        public fun useSemanticScoring(useSemanticScoring: Boolean?): Builder {
            this.useSemanticScoring = useSemanticScoring
            return this
        }

        public fun build(): MatchSearchRequest = MatchSearchRequest(resourceId = resourceId, referenceId = referenceId, context = context, limit = limit, useSemanticScoring = useSemanticScoring)
    }

    public companion object {
        /** A builder of a `MatchSearchRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, referenceId: AnnotationId, context: GatheredContext): Builder = Builder(resourceId, referenceId, context)
    }
}
