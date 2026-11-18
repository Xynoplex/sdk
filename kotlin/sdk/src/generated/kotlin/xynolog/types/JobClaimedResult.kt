// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The reply to a successful `job:claim`: the claimed job, now running under the claimant. */
@Serializable
public data class JobClaimedResult(
    public val response: JobRunning,
) {
    /** How Java makes a `JobClaimedResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: JobRunning,
    ) {
        public fun build(): JobClaimedResult = JobClaimedResult(response = response)
    }

    public companion object {
        /** A builder of a `JobClaimedResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: JobRunning): Builder = Builder(response)
    }
}
