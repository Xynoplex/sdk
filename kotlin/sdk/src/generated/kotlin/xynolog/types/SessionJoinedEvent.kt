// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** A participant opened a live connection to this KB — an SSE stream on /bus/subscribe. Presence is CONNECTION lifecycle, not login: a token can be minted and sit unused, so what this reports is that someone is WATCHING. One person with two tabs produces two of these, which is why connectionId is required — the DID alone cannot tell two connections apart, and a consumer that counts DIDs will undercount viewers. */
@Serializable
@JsonIgnoreUnknownKeys
public data class SessionJoinedEvent(
    /** DID of the authenticated principal on that connection. A person or a software agent — the bus does not distinguish. */
    @get:JvmExposeBoxed
    public val participant: UserId,
    /** Identifies this connection for its lifetime. The matching session:left carries the same value. */
    public val connectionId: String,
) {
    /** How Java makes a `SessionJoinedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val participant: UserId,
        private val connectionId: String,
    ) {
        public fun build(): SessionJoinedEvent = SessionJoinedEvent(participant = participant, connectionId = connectionId)
    }

    public companion object {
        /** A builder of a `SessionJoinedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(participant: UserId, connectionId: String): Builder = Builder(participant, connectionId)
    }
}
