// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** The payload of `mark:delegate-timeout`, a client-local signal: a delegated job went silent past its deadline, with no progress, no completion and no `job:fail`. A real job failure arrives as `job:fail` and never produces this. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkDelegateTimeoutEvent(
    /** The resource the job was delegated for. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    public val motivation: Motivation,
) {
    /** How Java makes a `MarkDelegateTimeoutEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val motivation: Motivation,
    ) {
        public fun build(): MarkDelegateTimeoutEvent = MarkDelegateTimeoutEvent(resourceId = resourceId, motivation = motivation)
    }

    public companion object {
        /** A builder of a `MarkDelegateTimeoutEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, motivation: Motivation): Builder = Builder(resourceId, motivation)
    }
}
