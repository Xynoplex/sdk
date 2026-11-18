// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Terminal success summary. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCompleteCreated(
    @EncodeDefault
    public val code: JobProgressCompleteCreatedCode = JobProgressCompleteCreatedCode.CompleteCreated,
    /** How many annotations were created */
    public val count: Long,
    /** The motivation of the job, and so of what it created. A client words it in its own language. */
    public val motivation: Motivation,
) : JobProgressMessage {
    /** How Java makes a `JobProgressCompleteCreated`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val count: Long,
        private val motivation: Motivation,
    ) {
        public fun build(): JobProgressCompleteCreated = JobProgressCompleteCreated(count = count, motivation = motivation)
    }

    public companion object {
        /** A builder of a `JobProgressCompleteCreated` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(count: Long, motivation: Motivation): Builder = Builder(count, motivation)
    }
}
