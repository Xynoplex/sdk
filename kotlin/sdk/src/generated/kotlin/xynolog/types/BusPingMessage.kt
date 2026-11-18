// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The heartbeat: `event: ping` with an empty `data:` line. The first is written once the stream has caught up (after any replay), then one every `x-xynolog-limits.heartbeatSeconds`. It carries no id, so it never disturbs a client's last-seen ids. */
@Serializable
public data class BusPingMessage(
    @EncodeDefault
    public val event: BusPingMessageEvent = BusPingMessageEvent.Ping,
    public val data: String,
) : BusStreamMessage {
    /** How Java makes a `BusPingMessage`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val data: String,
    ) {
        public fun build(): BusPingMessage = BusPingMessage(data = data)
    }

    public companion object {
        /** A builder of a `BusPingMessage` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(data: String): Builder = Builder(data)
    }
}
