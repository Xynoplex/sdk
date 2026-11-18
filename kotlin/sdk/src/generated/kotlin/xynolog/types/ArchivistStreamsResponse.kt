// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Every stream of the event log, `__system__` among them, each with the sequence number of its last event, in no order: the Archivist's answer to `GET /events`. */
@Serializable
public data class ArchivistStreamsResponse(
    public val streams: kotlin.collections.List<ArchivistStream>,
) {
    /** How Java makes a `ArchivistStreamsResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val streams: kotlin.collections.List<ArchivistStream>,
    ) {
        public fun build(): ArchivistStreamsResponse = ArchivistStreamsResponse(streams = streams)
    }

    public companion object {
        /** A builder of a `ArchivistStreamsResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(streams: kotlin.collections.List<ArchivistStream>): Builder = Builder(streams)
    }
}
