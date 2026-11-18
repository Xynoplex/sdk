// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

@Serializable
@JsonIgnoreUnknownKeys
public data class MediaTokenRequest(
    /** The resource ID to generate a media token for */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `MediaTokenRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        public fun build(): MediaTokenRequest = MediaTokenRequest(resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `MediaTokenRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
