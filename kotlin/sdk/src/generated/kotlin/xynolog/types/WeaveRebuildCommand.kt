// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command to rebuild the graph projection from the event log — the whole graph when resourceId is absent, one resource when present. Served by the Weaver; replaces direct rebuild access, which does not survive the Weaver's container split. */
@Serializable
@JsonIgnoreUnknownKeys
public data class WeaveRebuildCommand(
    /** When present, rebuild only this resource; otherwise clear and rebuild the entire graph. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
) {
    /** How Java makes a `WeaveRebuildCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var resourceId: ResourceId? = null
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): WeaveRebuildCommand = WeaveRebuildCommand(resourceId = resourceId, userId = userId)
    }

    public companion object {
        /** A builder of a `WeaveRebuildCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
