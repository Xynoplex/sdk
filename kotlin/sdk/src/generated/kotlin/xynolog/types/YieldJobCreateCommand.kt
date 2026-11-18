// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import xynolog.identifiers.UserId

/** Create a `yield` job: make a resource from a gathered context. It names no resource of its own: the job is about the resource its context focuses on, which the Dispatcher reads from `params.context.focus`. */
@Serializable
public data class YieldJobCreateCommand(
    /** The emitter's verified DID, injected by the gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /** The emitter's roles, injected by the gateway when it has any. Clients do not set this. */
    @SerialName("_roles")
    public val roles: kotlin.collections.List<String>? = null,
    @EncodeDefault
    public val jobType: YieldJobCreateCommandJobType = YieldJobCreateCommandJobType.Yield,
    public val params: GenerationJobParams,
) : JobCreateCommand {
    /** How Java makes a `YieldJobCreateCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val params: GenerationJobParams,
    ) {
        private var userId: UserId? = null
        private var roles: kotlin.collections.List<String>? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun roles(roles: kotlin.collections.List<String>?): Builder = apply { this.roles = roles }

        public fun build(): YieldJobCreateCommand = YieldJobCreateCommand(userId = userId, roles = roles, params = params)
    }

    public companion object {
        /** A builder of a `YieldJobCreateCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(params: GenerationJobParams): Builder = Builder(params)
    }
}
