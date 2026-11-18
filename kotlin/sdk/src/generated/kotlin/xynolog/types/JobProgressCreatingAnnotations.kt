// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Writing detected annotations back to the resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCreatingAnnotations(
    @EncodeDefault
    public val code: JobProgressCreatingAnnotationsCode = JobProgressCreatingAnnotationsCode.CreatingAnnotations,
    /** How many annotations are being created */
    public val count: Long,
) : JobProgressMessage {
    /** How Java makes a `JobProgressCreatingAnnotations`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val count: Long,
    ) {
        public fun build(): JobProgressCreatingAnnotations = JobProgressCreatingAnnotations(count = count)
    }

    public companion object {
        /** A builder of a `JobProgressCreatingAnnotations` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(count: Long): Builder = Builder(count)
    }
}
