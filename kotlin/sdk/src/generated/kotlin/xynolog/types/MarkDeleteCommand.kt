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

/** Bus command to delete an annotation. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkDeleteCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
) {
    /** How Java makes a `MarkDeleteCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
    ) {
        private var userId: UserId? = null
        private var resourceId: ResourceId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        public fun build(): MarkDeleteCommand = MarkDeleteCommand(userId = userId, annotationId = annotationId, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `MarkDeleteCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId): Builder = Builder(annotationId)
    }
}
