// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** Completion payload emitted on the gather:annotation-complete bus channel when annotation context gathering finishes. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherAnnotationComplete(
    /** Branded AnnotationId of the annotation whose context was gathered */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    /** The gathered annotation context (unified GatheredContext, focus.kind:'annotation') */
    public val response: GatheredContext,
) {
    /** How Java makes a `GatherAnnotationComplete`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val response: GatheredContext,
    ) {
        public fun build(): GatherAnnotationComplete = GatherAnnotationComplete(annotationId = annotationId, response = response)
    }

    public companion object {
        /** A builder of a `GatherAnnotationComplete` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, response: GatheredContext): Builder = Builder(annotationId, response)
    }
}
