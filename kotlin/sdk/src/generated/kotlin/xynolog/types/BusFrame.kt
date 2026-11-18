// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonObject
import xynolog.identifiers.ResourceId

/** One frame of the bus stream, as the `data` line of a `bus-event` message carries it (JSON-serialised on one line). `payload` is the channel's payload as its registry entry declares it. A frame on a scoped subscription carries the scope it was published on; a correlated reply carries the `correlationId` of the request it answers. */
@Serializable
public data class BusFrame(
    /** A channel of the bus registry (specs/src/bus/registry.json). */
    public val channel: String,
    /** The request this frame answers. Present on correlated replies; absent otherwise. */
    public val correlationId: String? = null,
    /** The channel's payload. A replayed persisted event is the stored event itself, whose `metadata.sequenceNumber` the message id carries. */
    public val payload: JsonObject,
    /** The resource scope the frame was published on. Present exactly when it arrived through a `scoped` entry of the subscription. */
    @get:JvmExposeBoxed
    public val scope: ResourceId? = null,
) {
    /** How Java makes a `BusFrame`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val channel: String,
        private val payload: JsonObject,
    ) {
        private var correlationId: String? = null
        private var scope: ResourceId? = null

        public fun correlationId(correlationId: String?): Builder = apply { this.correlationId = correlationId }

        @JvmExposeBoxed
        public fun scope(scope: ResourceId?): Builder = apply { this.scope = scope }

        public fun build(): BusFrame = BusFrame(channel = channel, correlationId = correlationId, payload = payload, scope = scope)
    }

    public companion object {
        /** A builder of a `BusFrame` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(channel: String, payload: JsonObject): Builder = Builder(channel, payload)
    }
}
