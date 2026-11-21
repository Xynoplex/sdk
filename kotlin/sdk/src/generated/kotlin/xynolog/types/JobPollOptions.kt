// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** How a job's `pollUntilComplete` asks for the job's status: how long it waits between its asks, and how long it goes on asking. A member left out is client/timing.json's: `jobPollMs` and `jobPollTimeoutMs`. */
@Serializable
public data class JobPollOptions(
    /** How long it waits between one ask and the next, in milliseconds. */
    public val everyMs: Long? = null,
    /** How long it goes on asking, from its first ask, before it fails as timed out, in milliseconds. */
    public val withinMs: Long? = null,
) {
    /** How Java makes a `JobPollOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var everyMs: Long? = null
        private var withinMs: Long? = null

        public fun everyMs(everyMs: Long?): Builder = apply { this.everyMs = everyMs }
        public fun withinMs(withinMs: Long?): Builder = apply { this.withinMs = withinMs }

        public fun build(): JobPollOptions = JobPollOptions(everyMs = everyMs, withinMs = withinMs)
    }

    public companion object {
        /** A builder of a `JobPollOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
