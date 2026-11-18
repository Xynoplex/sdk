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
public data class YieldCreateCommandGeneratedFrom(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
) {
    /** How Java makes a `YieldCreateCommandGeneratedFrom`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var resourceId: ResourceId? = null
        private var annotationId: AnnotationId? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun build(): YieldCreateCommandGeneratedFrom = YieldCreateCommandGeneratedFrom(resourceId = resourceId, annotationId = annotationId)
    }

    public companion object {
        /** A builder of a `YieldCreateCommandGeneratedFrom` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
