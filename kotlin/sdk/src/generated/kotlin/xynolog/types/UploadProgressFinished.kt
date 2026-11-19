// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import xynolog.identifiers.ResourceId

/** The upload ended, and the resource is made. */
@Serializable
public data class UploadProgressFinished(
    @EncodeDefault
    public val phase: UploadProgressFinishedPhase = UploadProgressFinishedPhase.Finished,
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
) : UploadProgress {
    /** How Java makes a `UploadProgressFinished`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
    ) {
        public fun build(): UploadProgressFinished = UploadProgressFinished(resourceId = resourceId)
    }

    public companion object {
        /** A builder of a `UploadProgressFinished` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId): Builder = Builder(resourceId)
    }
}
