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

/** Bus command to update an annotation's body with patch operations. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkUpdateBodyCommand(
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    @get:JvmExposeBoxed
    public val annotationId: AnnotationId,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val operations: kotlin.collections.List<MarkUpdateBodyCommandOperationsItem>,
) {
    /** How Java makes a `MarkUpdateBodyCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotationId: AnnotationId,
        private val resourceId: ResourceId,
        private val operations: kotlin.collections.List<MarkUpdateBodyCommandOperationsItem>,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): MarkUpdateBodyCommand = MarkUpdateBodyCommand(userId = userId, annotationId = annotationId, resourceId = resourceId, operations = operations)
    }

    public companion object {
        /** A builder of a `MarkUpdateBodyCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(annotationId: AnnotationId, resourceId: ResourceId, operations: kotlin.collections.List<MarkUpdateBodyCommandOperationsItem>): Builder = Builder(annotationId, resourceId, operations)
    }
}
