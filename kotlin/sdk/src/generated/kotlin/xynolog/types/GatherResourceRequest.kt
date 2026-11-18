// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Request payload sent on the gather:resource-requested bus channel to gather context for a resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherResourceRequest(
    /** Branded ResourceId of the resource to gather context for */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val options: GatherResourceRequestOptions,
) {
    /** How Java makes a `GatherResourceRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val options: GatherResourceRequestOptions,
    ) {
        public fun build(): GatherResourceRequest = GatherResourceRequest(resourceId = resourceId, options = options)
    }

    public companion object {
        /** A builder of a `GatherResourceRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, options: GatherResourceRequestOptions): Builder = Builder(resourceId, options)
    }
}
