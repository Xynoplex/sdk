// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Domain intent to open a resource in the viewer: emitted locally by in-app link handlers and remotely by the launcher's tour verbs; the viewer translates it to host routing (nav:push), which never crosses the wire. Deliberately not named 'navigate' — that word and the nav:* prefix belong to the host-local framework layer. */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseResourceOpenEvent(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `BrowseResourceOpenEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        public fun build(): BrowseResourceOpenEvent = BrowseResourceOpenEvent(resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `BrowseResourceOpenEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
