// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** Bus command saying what a principal is called. The gateway emits it when a principal ACTS, carrying the display name it just verified on its token; a principal may also emit it itself, for itself, which is how an agent, whose token carries no name, says what it is called. Either way the gateway stamps `_userId` with the sender's verified DID, so a principal names only itself. The Stower persists it as principal:profiled, and only when the name differs from the latest one recorded for that DID — so the log holds one line per name a principal has had, not one per act. A name is a fact ABOUT an identity, never part of the record of an act: no artifact carries it, and readers resolve it from the profiles projection. Emitted for a person and for an agent alike; never for a request that merely reads. */
@Serializable
@JsonIgnoreUnknownKeys
public data class PrincipalProfileCommand(
    /** The principal's DID, injected by the /bus/emit gateway from the verified token. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    /** The display name: from the issuer's `name` claim, as verified on the token that carried an act, or what the principal said of itself. A token with no name produces no command from the gateway — the issuer is where a person's name is set, and absence is recorded as absence. */
    public val name: String,
) {
    /** How Java makes a `PrincipalProfileCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): PrincipalProfileCommand = PrincipalProfileCommand(userId = userId, name = name)
    }

    public companion object {
        /** A builder of a `PrincipalProfileCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String): Builder = Builder(name)
    }
}
