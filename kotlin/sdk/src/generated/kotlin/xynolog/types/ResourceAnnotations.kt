// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** The annotations on one resource, as its materialized view holds them. */
@Serializable
public data class ResourceAnnotations(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Each annotation as the `mark:added` event that recorded it carried it, with the body changes recorded since applied. In the order they were first recorded. */
    public val annotations: kotlin.collections.List<Annotation>,
    /** How many of the resource's events the view has applied. */
    public val version: Long,
    /** The timestamp of the last event applied; the empty string before any. */
    public val updatedAt: String,
) {
    /** How Java makes a `ResourceAnnotations`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val annotations: kotlin.collections.List<Annotation>,
        private val version: Long,
        private val updatedAt: String,
    ) {
        public fun build(): ResourceAnnotations = ResourceAnnotations(resourceId = resourceId, annotations = annotations, version = version, updatedAt = updatedAt)
    }

    public companion object {
        /** A builder of a `ResourceAnnotations` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, annotations: kotlin.collections.List<Annotation>, version: Long, updatedAt: String): Builder = Builder(resourceId, annotations, version, updatedAt)
    }
}
