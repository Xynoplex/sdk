// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** Claim the NEXT pending job that matches one of `accepts` (atomic: pending → running). A job:queued announcement is a WAKE-UP, not a reservation: the claimed job may differ from the announced one, and two claims after one announcement both succeed on different jobs instead of racing for one. job:claimed carries the claimed job; job:claim-failed reports that nothing matching is pending. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobClaimCommand(
    /** The jobs this claim takes. A job is handed over when it matches any one of them. */
    public val accepts: kotlin.collections.List<JobFilter>,
    /** Authenticated claimant's DID, injected by the /bus/emit gateway. Clients do not set this. The dispatcher records it as the holder on job:assigned. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /** The claimant's capabilities (the token's `roles`), injected by the /bus/emit gateway. Clients do not set this. The dispatcher authorizes the claim by capability — it admits the claim only when this carries the worker role — so a claimant that is not a worker for this knowledge base is refused before the queue is consulted. */
    @SerialName("_roles")
    public val roles: kotlin.collections.List<String>? = null,
) {
    /** How Java makes a `JobClaimCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val accepts: kotlin.collections.List<JobFilter>,
    ) {
        private var userId: UserId? = null
        private var roles: kotlin.collections.List<String>? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun roles(roles: kotlin.collections.List<String>?): Builder = apply { this.roles = roles }

        public fun build(): JobClaimCommand = JobClaimCommand(accepts = accepts, userId = userId, roles = roles)
    }

    public companion object {
        /** A builder of a `JobClaimCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(accepts: kotlin.collections.List<JobFilter>): Builder = Builder(accepts)
    }
}
