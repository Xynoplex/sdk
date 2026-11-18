// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** What this gateway process can hold, from the memory its deployment gives it. `queuedBytes`: the bytes queued for all its streams together; at it, a new stream is refused with 503 (`AtCapacity`, code `capacity`) until the queues drain — each stream's own bound is `x-xynolog-limits.pendingWriteBytes`. `connections`: the connections it holds open at once; one past it is closed unanswered. The launcher derives both from the memory it gives the gateway's container. */
@Serializable
public data class GatewayConfigCapacity(
    public val queuedBytes: Long,
    public val connections: Long,
) {
    /** How Java makes a `GatewayConfigCapacity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val queuedBytes: Long,
        private val connections: Long,
    ) {
        public fun build(): GatewayConfigCapacity = GatewayConfigCapacity(queuedBytes = queuedBytes, connections = connections)
    }

    public companion object {
        /** A builder of a `GatewayConfigCapacity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(queuedBytes: Long, connections: Long): Builder = Builder(queuedBytes, connections)
    }
}
