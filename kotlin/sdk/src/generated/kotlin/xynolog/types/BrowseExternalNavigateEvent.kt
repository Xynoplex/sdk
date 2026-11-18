// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Emitted when navigation to an external URL is requested */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseExternalNavigateEvent(
    public val url: String,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
) {
    /** How Java makes a `BrowseExternalNavigateEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val url: String,
    ) {
        private var resourceId: ResourceId? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        public fun build(): BrowseExternalNavigateEvent = BrowseExternalNavigateEvent(url = url, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `BrowseExternalNavigateEvent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(url: String): Builder = Builder(url)
    }
}
