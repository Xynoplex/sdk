// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

@Serializable
@JsonIgnoreUnknownKeys
public data class UpdateAnnotationBodyRequest(
    /** Resource ID containing the annotation (required for O(1) Layer 3 lookup) */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Array of body modification operations to apply */
    public val operations: kotlin.collections.List<BodyOperation>,
) {
    /** How Java makes a `UpdateAnnotationBodyRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val operations: kotlin.collections.List<BodyOperation>,
    ) {
        public fun build(): UpdateAnnotationBodyRequest = UpdateAnnotationBodyRequest(resourceId = resourceId, operations = operations)
    }

    public companion object {
        /** A builder of a `UpdateAnnotationBodyRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, operations: kotlin.collections.List<BodyOperation>): Builder = Builder(resourceId, operations)
    }
}
