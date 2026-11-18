// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Writing detected tag annotations back to the resource. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCreatingTagAnnotations(
    @EncodeDefault
    public val code: JobProgressCreatingTagAnnotationsCode = JobProgressCreatingTagAnnotationsCode.CreatingTagAnnotations,
    /** How many annotations are being created */
    public val count: Long,
) : JobProgressMessage {
    /** How Java makes a `JobProgressCreatingTagAnnotations`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val count: Long,
    ) {
        public fun build(): JobProgressCreatingTagAnnotations = JobProgressCreatingTagAnnotations(count = count)
    }

    public companion object {
        /** A builder of a `JobProgressCreatingTagAnnotations` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(count: Long): Builder = Builder(count)
    }
}
