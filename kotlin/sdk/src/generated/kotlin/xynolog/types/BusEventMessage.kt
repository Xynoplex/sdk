// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A bus frame on the stream: `event: bus-event`, an `id:` line, and one `data:` line holding the JSON-serialised BusFrame. This schema describes the message with `data` already parsed. */
@Serializable
public data class BusEventMessage(
    @EncodeDefault
    public val event: BusEventMessageEvent = BusEventMessageEvent.BusEvent,
    public val id: String,
    public val data: BusFrame,
) : BusStreamMessage {
    /** How Java makes a `BusEventMessage`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val data: BusFrame,
    ) {
        public fun build(): BusEventMessage = BusEventMessage(id = id, data = data)
    }

    public companion object {
        /** A builder of a `BusEventMessage` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, data: BusFrame): Builder = Builder(id, data)
    }
}
