// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Command payload sent on the bind:update-body bus channel to modify annotation bodies. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BindUpdateBodyCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /** Branded AnnotationId of the annotation whose body is being updated */
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    /** Branded ResourceId of the resource the annotation belongs to */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Ordered body-list edits to apply. */
    public val operations: kotlin.collections.List<BindBodyOperation>,
) {
    /** How Java makes a `BindUpdateBodyCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
        private val operations: kotlin.collections.List<BindBodyOperation>,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): BindUpdateBodyCommand = BindUpdateBodyCommand(userId = userId, annotationId = annotationId, resourceId = resourceId, operations = operations)
    }

    public companion object {
        /** A builder of a `BindUpdateBodyCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, resourceId: ResourceId, operations: kotlin.collections.List<BindBodyOperation>): Builder = Builder(annotationId, resourceId, operations)
    }
}
