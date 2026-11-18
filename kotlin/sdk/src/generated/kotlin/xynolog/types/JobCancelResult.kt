// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** What a cancel did, in the `response` of `job:cancel-ok`: whether the queue acted on the job it named. A pending job is cancelled outright; a running one is left to its worker, so for it true means accepted, not stopped. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCancelResult(
    /** True when the queue acted on the job; false when the job is unknown or already over. */
    public val cancelled: Boolean,
) {
    /** How Java makes a `JobCancelResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val cancelled: Boolean,
    ) {
        public fun build(): JobCancelResult = JobCancelResult(cancelled = cancelled)
    }

    public companion object {
        /** A builder of a `JobCancelResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(cancelled: Boolean): Builder = Builder(cancelled)
    }
}
