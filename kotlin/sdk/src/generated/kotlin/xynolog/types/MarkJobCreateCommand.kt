// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Create a `mark` job: annotate one resource for one motivation. */
@Serializable
public data class MarkJobCreateCommand(
    /** The emitter's verified DID, injected by the gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /** The emitter's roles, injected by the gateway when it has any. Clients do not set this. */
    @SerialName("_roles")
    public val roles: kotlin.collections.List<String>? = null,
    @EncodeDefault
    public val jobType: MarkJobCreateCommandJobType = MarkJobCreateCommandJobType.Mark,
    /** The resource to annotate. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val params: MarkJobParams,
) : JobCreateCommand {
    /** How Java makes a `MarkJobCreateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val params: MarkJobParams,
    ) {
        private var userId: UserId? = null
        private var roles: kotlin.collections.List<String>? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun roles(roles: kotlin.collections.List<String>?): Builder = apply { this.roles = roles }

        public fun build(): MarkJobCreateCommand = MarkJobCreateCommand(userId = userId, roles = roles, resourceId = resourceId, params = params)
    }

    public companion object {
        /** A builder of a `MarkJobCreateCommand` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, params: MarkJobParams): Builder = Builder(resourceId, params)
    }
}
