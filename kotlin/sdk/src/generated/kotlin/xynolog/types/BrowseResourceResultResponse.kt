// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable
public data class BrowseResourceResultResponse(
    public val resource: ResourceDescriptor,
    /** The sequence number of the resource's last event. A graph read that follows a write waits for the graph projection to reach it. */
    public val lastSequence: Long,
) {
    /** How Java makes a `BrowseResourceResultResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resource: ResourceDescriptor,
        private val lastSequence: Long,
    ) {
        public fun build(): BrowseResourceResultResponse = BrowseResourceResultResponse(resource = resource, lastSequence = lastSequence)
    }

    public companion object {
        /** A builder of a `BrowseResourceResultResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resource: ResourceDescriptor, lastSequence: Long): Builder = Builder(resource, lastSequence)
    }
}
