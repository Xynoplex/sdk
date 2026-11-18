// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class ListResourcesResponse(
    public val resources: kotlin.collections.List<ResourceDescriptor>,
    public val total: Double,
    public val offset: Double,
    public val limit: Double,
) {
    /** How Java makes a `ListResourcesResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resources: kotlin.collections.List<ResourceDescriptor>,
        private val total: Double,
        private val offset: Double,
        private val limit: Double,
    ) {
        public fun build(): ListResourcesResponse = ListResourcesResponse(resources = resources, total = total, offset = offset, limit = limit)
    }

    public companion object {
        /** A builder of a `ListResourcesResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resources: kotlin.collections.List<ResourceDescriptor>, total: Double, offset: Double, limit: Double): Builder = Builder(resources, total, offset, limit)
    }
}
