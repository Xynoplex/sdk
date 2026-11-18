// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** The resource a yield command wrote, by its id. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldedResource(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `YieldedResource`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        public fun build(): YieldedResource = YieldedResource(resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `YieldedResource` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
