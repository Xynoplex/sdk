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
public data class SemanticMatch(
    /** The chunk text that matched */
    public val text: String,
    /** Source resource ID */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The source resource's display name, resolved from its view at gather time. Required: a match card must name its source, and corpus matches routinely come from outside the graph neighborhood, so there is no node to borrow a name from. A match whose source no longer resolves to a view is dropped by the producer rather than served nameless. */
    public val resourceName: String,
    /** Source annotation ID, if the match is from an annotation */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId? = null,
    /** Cosine similarity score (0-1) */
    public val score: Double,
    /** Entity types on the matched passage */
    public val entityTypes: kotlin.collections.List<String>? = null,
    /** True when this passage's text was recognized from pixels (OCR of a scanned page) rather than read from the document. Absent means read directly — the common case — so the flag is only present where it changes how the text should be trusted. It travels with the passage because a consumer receives the chunk with no document attached and cannot recompute how the text was obtained. */
    public val machineRead: Boolean? = null,
) {
    /** How Java makes a `SemanticMatch`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
        private val resourceId: ResourceId,
        private val resourceName: String,
        private val score: Double,
    ) {
        private var annotationId: AnnotationId? = null
        private var entityTypes: kotlin.collections.List<String>? = null
        private var machineRead: Boolean? = null

        @JvmExposeBoxed
        public fun annotationId(annotationId: AnnotationId?): Builder = apply { this.annotationId = annotationId }

        public fun entityTypes(entityTypes: kotlin.collections.List<String>?): Builder = apply { this.entityTypes = entityTypes }
        public fun machineRead(machineRead: Boolean?): Builder = apply { this.machineRead = machineRead }

        public fun build(): SemanticMatch = SemanticMatch(text = text, resourceId = resourceId, resourceName = resourceName, annotationId = annotationId, score = score, entityTypes = entityTypes, machineRead = machineRead)
    }

    public companion object {
        /** A builder of a `SemanticMatch` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(text: String, resourceId: ResourceId, resourceName: String, score: Double): Builder = Builder(text, resourceId, resourceName, score)
    }
}
