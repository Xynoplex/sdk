// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** A resource's materialized view: the file the Archivist writes at `resources/<ab>/<cd>/<resourceId>.json` under the knowledge base's state directory, and every reader of that file reads. It is what the resource's events add up to, and is rebuilt from the event log whenever it is missing. Written as JSON indented by two spaces, by writing a sibling temporary file and renaming it onto the path, so a reader sees a whole document or none. */
@Serializable
public data class ResourceView(
    public val resource: ResourceDescriptor,
    public val annotations: ResourceAnnotations,
    /** The sequence number of the last event applied. A graph read that follows a write waits for the graph projection to reach it. */
    public val lastSequence: Long,
) {
    /** How Java makes a `ResourceView`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resource: ResourceDescriptor,
        private val annotations: ResourceAnnotations,
        private val lastSequence: Long,
    ) {
        public fun build(): ResourceView = ResourceView(resource = resource, annotations = annotations, lastSequence = lastSequence)
    }

    public companion object {
        /** A builder of a `ResourceView` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resource: ResourceDescriptor, annotations: ResourceAnnotations, lastSequence: Long): Builder = Builder(resource, annotations, lastSequence)
    }
}
