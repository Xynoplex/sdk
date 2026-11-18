// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

@Serializable
@JsonIgnoreUnknownKeys
public data class GetAnnotationHistoryResponse(
    public val events: kotlin.collections.List<AttributedEvent>,
    public val total: Double,
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `GetAnnotationHistoryResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val events: kotlin.collections.List<AttributedEvent>,
        private val total: Double,
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
    ) {
        public fun build(): GetAnnotationHistoryResponse = GetAnnotationHistoryResponse(events = events, total = total, annotationId = annotationId, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `GetAnnotationHistoryResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(events: kotlin.collections.List<AttributedEvent>, total: Double, annotationId: AnnotationId, resourceId: ResourceId): Builder = Builder(events, total, annotationId, resourceId)
    }
}
