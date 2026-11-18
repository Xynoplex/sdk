// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Bus command to rebuild anchored-text artifacts by re-running extraction — every geometry-capable resource when resourceId is absent, one resource when present. Served by the Smelter, serialized (each unit can be a multi-second OCR pass), and never destructive: nothing is deleted first, stale entries are simply overwritten. Re-anchoring makes zero embedding calls — the vectors are already correct; only the derived map is re-made. Partial completion replies failed, with counts: a rebuild that quietly skipped resources would present exactly like a document with no text. */
@Serializable
@JsonIgnoreUnknownKeys
public data class SmeltRebuildAnchorsCommand(
    /** When present, re-anchor only this resource; otherwise every geometry-capable resource in the catalog. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId? = null,
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
) {
    /** How Java makes a `SmeltRebuildAnchorsCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var resourceId: ResourceId? = null
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun resourceId(resourceId: ResourceId?): Builder = apply { this.resourceId = resourceId }

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): SmeltRebuildAnchorsCommand = SmeltRebuildAnchorsCommand(resourceId = resourceId, userId = userId)
    }

    public companion object {
        /** A builder of a `SmeltRebuildAnchorsCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
