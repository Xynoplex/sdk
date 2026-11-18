// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId

/** Command payload sent on the bind:initiate bus channel to start a bind flow. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BindInitiateCommand(
    /** Branded AnnotationId of the annotation being bound */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    /** Branded ResourceId of the resource being bound to */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Default title for the bound annotation */
    public val defaultTitle: String,
    /** Entity types to associate with the annotation */
    public val entityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `BindInitiateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
        private val defaultTitle: String,
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        public fun build(): BindInitiateCommand = BindInitiateCommand(annotationId = annotationId, resourceId = resourceId, defaultTitle = defaultTitle, entityTypes = entityTypes)
    }

    public companion object {
        /** A builder of a `BindInitiateCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, resourceId: ResourceId, defaultTitle: String, entityTypes: kotlin.collections.List<String>): Builder = Builder(annotationId, resourceId, defaultTitle, entityTypes)
    }
}
