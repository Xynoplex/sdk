// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** The payload of `weave:applied`: the Weaver has applied a resource's events to the graph up to this sequence number. Emitted after applying an event, or a batch's last event. */
@Serializable
@JsonIgnoreUnknownKeys
public data class WeaveApplied(
    /** The resource whose events were applied. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The resource-stream sequence of the last applied event. */
    public val sequenceNumber: Long,
) {
    /** How Java makes a `WeaveApplied`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val sequenceNumber: Long,
    ) {
        public fun build(): WeaveApplied = WeaveApplied(resourceId = resourceId, sequenceNumber = sequenceNumber)
    }

    public companion object {
        /** A builder of a `WeaveApplied` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, sequenceNumber: Long): Builder = Builder(resourceId, sequenceNumber)
    }
}
