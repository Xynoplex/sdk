// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Request payload sent on the match:search-request bus channel to find candidate matches. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MatchSearchRequest(
    /** Resource ID the reference annotation belongs to. Used to scope result events on the EventBus so the events-stream delivers them to participants viewing this resource. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Annotation ID of the reference to search candidates for */
    @get:JvmExposeBoxed
    public val referenceId: AnnotationId,
    /** Gathered context for the reference annotation */
    public val context: GatheredContext,
    /** Maximum number of candidate results to return */
    public val limit: Long? = null,
    /** Enable semantic similarity scoring in addition to keyword matching */
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

        public fun limit(limit: Long?): Builder = apply { this.limit = limit }
        public fun useSemanticScoring(useSemanticScoring: Boolean?): Builder = apply { this.useSemanticScoring = useSemanticScoring }

        public fun build(): MatchSearchRequest = MatchSearchRequest(resourceId = resourceId, referenceId = referenceId, context = context, limit = limit, useSemanticScoring = useSemanticScoring)
    }

    public companion object {
        /** A builder of a `MatchSearchRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, referenceId: AnnotationId, context: GatheredContext): Builder = Builder(resourceId, referenceId, context)
    }
}
