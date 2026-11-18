// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** Payload for mark:removed domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnnotationRemovedPayload(
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
) {
    /** How Java makes a `AnnotationRemovedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
    ) {
        public fun build(): AnnotationRemovedPayload = AnnotationRemovedPayload(annotationId = annotationId)
    }

    public companion object {
        /** A builder of a `AnnotationRemovedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId): Builder = Builder(annotationId)
    }
}
