// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** What a `yield` job reports when it has made its resource. The worker creates the resource first (the create round trip returns its id), then emits job:complete carrying it, so resourceId is always present on the wire. */
@Serializable
public data class YieldJobDone(
    /** ID of the generated resource, obtained by the worker from the create round-trip before job:complete is emitted */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Name of the generated resource */
    public val resourceName: String,
    /** True when the model stopped at the maxTokens ceiling — the artifact is cut off, not complete. Derived at the producer from the provider's stopReason ('max_tokens' → true); required because the worker always knows. */
    public val truncated: Boolean,
) : JobResult,
    YieldJobResult {
    /** How Java makes a `YieldJobDone`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val resourceName: String,
        private val truncated: Boolean,
    ) {
        public fun build(): YieldJobDone = YieldJobDone(resourceId = resourceId, resourceName = resourceName, truncated = truncated)
    }

    public companion object {
        /** A builder of a `YieldJobDone` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, resourceName: String, truncated: Boolean): Builder = Builder(resourceId, resourceName, truncated)
    }
}
