// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId

/** Payload for mark:body-updated domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnnotationBodyUpdatedPayload(
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    public val operations: kotlin.collections.List<AnnotationBodyUpdatedPayloadOperationsItem>,
) {
    /** How Java makes a `AnnotationBodyUpdatedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val operations: kotlin.collections.List<AnnotationBodyUpdatedPayloadOperationsItem>,
    ) {
        public fun build(): AnnotationBodyUpdatedPayload = AnnotationBodyUpdatedPayload(annotationId = annotationId, operations = operations)
    }

    public companion object {
        /** A builder of a `AnnotationBodyUpdatedPayload` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, operations: kotlin.collections.List<AnnotationBodyUpdatedPayloadOperationsItem>): Builder = Builder(annotationId, operations)
    }
}
