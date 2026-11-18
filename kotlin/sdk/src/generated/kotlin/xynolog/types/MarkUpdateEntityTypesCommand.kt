// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command to replace the entity types on a resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkUpdateEntityTypesCommand(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    public val currentEntityTypes: kotlin.collections.List<String>,
    public val updatedEntityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `MarkUpdateEntityTypesCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val currentEntityTypes: kotlin.collections.List<String>,
        private val updatedEntityTypes: kotlin.collections.List<String>,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): MarkUpdateEntityTypesCommand = MarkUpdateEntityTypesCommand(resourceId = resourceId, userId = userId, currentEntityTypes = currentEntityTypes, updatedEntityTypes = updatedEntityTypes)
    }

    public companion object {
        /** A builder of a `MarkUpdateEntityTypesCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, currentEntityTypes: kotlin.collections.List<String>, updatedEntityTypes: kotlin.collections.List<String>): Builder = Builder(resourceId, currentEntityTypes, updatedEntityTypes)
    }
}
