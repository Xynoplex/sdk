// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** Completion payload emitted on the gather:resource-complete bus channel when resource context gathering finishes. */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherResourceComplete(
    /** Branded ResourceId of the resource whose context was gathered */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The gathered resource context (unified GatheredContext, focus.kind:'resource') */
    public val response: GatheredContext,
) {
    /** How Java makes a `GatherResourceComplete`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val response: GatheredContext,
    ) {
        public fun build(): GatherResourceComplete = GatherResourceComplete(resourceId = resourceId, response = response)
    }

    public companion object {
        /** A builder of a `GatherResourceComplete` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, response: GatheredContext): Builder = Builder(resourceId, response)
    }
}
