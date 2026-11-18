// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

@Serializable
@JsonIgnoreUnknownKeys
public data class GetEventsResponse(
    public val events: kotlin.collections.List<AttributedEvent>,
    public val total: Double,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) {
    /** How Java makes a `GetEventsResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val events: kotlin.collections.List<AttributedEvent>,
        private val total: Double,
        private val resourceId: ResourceId,
    ) {
        public fun build(): GetEventsResponse = GetEventsResponse(events = events, total = total, resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `GetEventsResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(events: kotlin.collections.List<AttributedEvent>, total: Double, resourceId: ResourceId): Builder = Builder(events, total, resourceId)
    }
}
