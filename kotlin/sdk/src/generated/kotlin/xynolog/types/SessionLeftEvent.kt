// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** A participant's live connection to this KB ended — the SSE stream aborted. Carries the same connectionId as the session:joined that opened it, so a consumer tracking who is present can retire the right connection rather than assuming one per participant. */
@Serializable
@JsonIgnoreUnknownKeys
public data class SessionLeftEvent(
    /** DID of the authenticated principal on that connection. */
    @get:JvmExposeBoxed
    public val participant: UserId,
    /** The connectionId announced by the matching session:joined. */
    public val connectionId: String,
) {
    /** How Java makes a `SessionLeftEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val participant: UserId,
        private val connectionId: String,
    ) {
        public fun build(): SessionLeftEvent = SessionLeftEvent(participant = participant, connectionId = connectionId)
    }

    public companion object {
        /** A builder of a `SessionLeftEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(participant: UserId, connectionId: String): Builder = Builder(participant, connectionId)
    }
}
