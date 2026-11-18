// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** A client-local notice that a command on a resource failed, for a UI to show: the payload of `mark:create-error`, `mark:delete-error` and `bind:body-error`. Emitted by the caller that awaited the command, which knows whose command failed on which resource. The `*-failed` wire replies are correlation plumbing and are not for this. */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceErrorEvent(
    /** The resource the command addressed. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** Human-readable error message. */
    public val message: String,
) {
    /** How Java makes a `ResourceErrorEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val message: String,
    ) {
        public fun build(): ResourceErrorEvent = ResourceErrorEvent(resourceId = resourceId, message = message)
    }

    public companion object {
        /** A builder of a `ResourceErrorEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, message: String): Builder = Builder(resourceId, message)
    }
}
