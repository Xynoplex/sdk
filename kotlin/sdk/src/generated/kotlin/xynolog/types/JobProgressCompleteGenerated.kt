// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Generation's terminal success. Deliberately generic — the client already holds the title it typed, and the outcome (name + resource link) travels on job:complete, not on progress. `truncated` qualifies the completion: the same bit `YieldJobDone.truncated` carries, so the two surfaces cannot drift. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressCompleteGenerated(
    @EncodeDefault
    public val code: JobProgressCompleteGeneratedCode = JobProgressCompleteGeneratedCode.CompleteGenerated,
    /** True when the model stopped at the maxTokens ceiling — the artifact is cut off, not complete. */
    public val truncated: Boolean,
) : JobProgressMessage {
    /** How Java makes a `JobProgressCompleteGenerated`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val truncated: Boolean,
    ) {
        public fun build(): JobProgressCompleteGenerated = JobProgressCompleteGenerated(truncated = truncated)
    }

    public companion object {
        /** A builder of a `JobProgressCompleteGenerated` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(truncated: Boolean): Builder = Builder(truncated)
    }
}
