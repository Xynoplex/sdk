// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

@Serializable
public data class BusSubscribeRequestScopedItem(
    /** Resource scope (a resourceId). */
    @get:JvmExposeBoxed
    public val scope: ResourceId,
    /** Channels to subscribe within this scope. */
    public val channels: kotlin.collections.List<String>,
    /** This scope's last-seen PersistedEventId. The gateway replays this scope's persisted events after it — those on the entry's channels — before the live tail, and writes a scoped `bus:resume-gap` (BusResumeGap) when it cannot cover the gap. */
    public val lastEventId: String? = null,
) {
    /** How Java makes a `BusSubscribeRequestScopedItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val scope: ResourceId,
        private val channels: kotlin.collections.List<String>,
    ) {
        private var lastEventId: String? = null

        public fun lastEventId(lastEventId: String?): Builder = apply { this.lastEventId = lastEventId }

        public fun build(): BusSubscribeRequestScopedItem = BusSubscribeRequestScopedItem(scope = scope, channels = channels, lastEventId = lastEventId)
    }

    public companion object {
        /** A builder of a `BusSubscribeRequestScopedItem` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(scope: ResourceId, channels: kotlin.collections.List<String>): Builder = Builder(scope, channels)
    }
}
