// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** One stream of the event log, and where it stands: the resource it is of, or `__system__` for the knowledge base's own, and the sequence number of its last event. */
@Serializable
public data class ArchivistStream(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The sequence number of the stream's last event when it was read: 0 for a stream with none. */
    public val lastSequence: Long,
) {
    /** How Java makes a `ArchivistStream`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val lastSequence: Long,
    ) {
        public fun build(): ArchivistStream = ArchivistStream(resourceId = resourceId, lastSequence = lastSequence)
    }

    public companion object {
        /** A builder of a `ArchivistStream` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, lastSequence: Long): Builder = Builder(resourceId, lastSequence)
    }
}
