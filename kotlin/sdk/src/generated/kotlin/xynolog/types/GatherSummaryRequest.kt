// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Request to generate an AI summary of an annotation */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherSummaryRequest(
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `GatherSummaryRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
    ) {
        public fun build(): GatherSummaryRequest = GatherSummaryRequest(annotationId = annotationId, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `GatherSummaryRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, resourceId: ResourceId): Builder = Builder(annotationId, resourceId)
    }
}
