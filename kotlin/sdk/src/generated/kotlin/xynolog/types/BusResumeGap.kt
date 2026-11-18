// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** The payload of `bus:resume-gap`: a scope's `lastEventId` could not be honoured, so the client cannot trust that it has every persisted event of that scope and must refetch what it caches for it. Written by the gateway, never by a participant. */
@Serializable
public data class BusResumeGap(
    /** The scope of the subscription entry whose watermark failed. */
    @get:JvmExposeBoxed
    public val scope: ResourceId,
    /** The watermark the entry carried. */
    public val lastSeenId: String,
    /** `unparseable-last-event-id`: the watermark is not a PersistedEventId. `scope-mismatch`: it names another scope. `retention-exceeded`: the record no longer holds the events after it (what it still holds is replayed first). `query-error`: the record could not be read. */
    public val reason: BusResumeGapReason,
) {
    /** How Java makes a `BusResumeGap`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val scope: ResourceId,
        private val lastSeenId: String,
        private val reason: BusResumeGapReason,
    ) {
        public fun build(): BusResumeGap = BusResumeGap(scope = scope, lastSeenId = lastSeenId, reason = reason)
    }

    public companion object {
        /** A builder of a `BusResumeGap` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(scope: ResourceId, lastSeenId: String, reason: BusResumeGapReason): Builder = Builder(scope, lastSeenId, reason)
    }
}
