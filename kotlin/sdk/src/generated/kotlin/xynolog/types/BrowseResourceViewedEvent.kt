// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** REPORT that a resource has loaded in a viewer — emitted on arrival by ANY means: a followed cue, an in-app link, the back button, a typed URL. Deliberately distinct from the imperative browse:resource-open: drive and report never share a channel, or the driver hears its own commands and one viewer's arrival steers another's page. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseResourceViewedEvent(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `BrowseResourceViewedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        public fun build(): BrowseResourceViewedEvent = BrowseResourceViewedEvent(resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `BrowseResourceViewedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
