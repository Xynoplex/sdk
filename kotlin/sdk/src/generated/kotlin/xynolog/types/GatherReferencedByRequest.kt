// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Request for the annotations elsewhere that refer to a resource. The Librarian answers from the graph. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherReferencedByRequest(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The one motivation the annotations answered have. Every annotation that refers to the resource is answered where none is stated. */
    public val motivation: Motivation? = null,
) {
    /** How Java makes a `GatherReferencedByRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var motivation: Motivation? = null

        public fun motivation(motivation: Motivation?): Builder = apply { this.motivation = motivation }

        public fun build(): GatherReferencedByRequest = GatherReferencedByRequest(resourceId = resourceId, motivation = motivation)
    }

    public companion object {
        /** A builder of a `GatherReferencedByRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
