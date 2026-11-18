// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Request to browse a single annotation */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseAnnotationRequest(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
) {
    /** How Java makes a `BrowseAnnotationRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val annotationId: AnnotationId,
    ) {
        public fun build(): BrowseAnnotationRequest = BrowseAnnotationRequest(resourceId = resourceId, annotationId = annotationId)
    }

    public companion object {
        /** A builder of a `BrowseAnnotationRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, annotationId: AnnotationId): Builder = Builder(resourceId, annotationId)
    }
}
