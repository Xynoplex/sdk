// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/** Request to browse events for a resource */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseEventsRequest(
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val type: String? = null,
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
    public val limit: Long? = null,
) {
    /** How Java makes a `BrowseEventsRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        private var type: String? = null
        private var userId: UserId? = null
        private var limit: Long? = null

        public fun type(type: String?): Builder = apply { this.type = type }

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun limit(limit: Long?): Builder = apply { this.limit = limit }

        public fun build(): BrowseEventsRequest = BrowseEventsRequest(resourceId = resourceId, type = type, userId = userId, limit = limit)
    }

    public companion object {
        /** A builder of a `BrowseEventsRequest` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
