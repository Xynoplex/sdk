// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a worker's claiming of jobs is told: the jobs it takes, and how long it waits for what it waits on. A wait left out is client/timing.json's of the same name. */
@Serializable
public data class ClaimOptions(
    /** The jobs this claim takes. A job is handed over when it matches any one of them. */
    public val accepts: kotlin.collections.List<JobFilter>,
    /** How long it waits for the answer to one claim, in milliseconds. */
    public val jobClaimTimeoutMs: Long? = null,
    /** How long a held job may show no activity before it is called stalled, in milliseconds. */
    public val heldJobStallMs: Long? = null,
    /** How often it looks at how long a held job has shown no activity, in milliseconds. */
    public val heldJobStallCheckMs: Long? = null,
    /** How long it waits for the record to acknowledge a commit of annotations, in milliseconds. */
    public val markCommitTimeoutMs: Long? = null,
) {
    /** How Java makes a `ClaimOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val accepts: kotlin.collections.List<JobFilter>,
    ) {
        private var jobClaimTimeoutMs: Long? = null
        private var heldJobStallMs: Long? = null
        private var heldJobStallCheckMs: Long? = null
        private var markCommitTimeoutMs: Long? = null

        public fun jobClaimTimeoutMs(jobClaimTimeoutMs: Long?): Builder = apply { this.jobClaimTimeoutMs = jobClaimTimeoutMs }
        public fun heldJobStallMs(heldJobStallMs: Long?): Builder = apply { this.heldJobStallMs = heldJobStallMs }
        public fun heldJobStallCheckMs(heldJobStallCheckMs: Long?): Builder = apply { this.heldJobStallCheckMs = heldJobStallCheckMs }
        public fun markCommitTimeoutMs(markCommitTimeoutMs: Long?): Builder = apply { this.markCommitTimeoutMs = markCommitTimeoutMs }

        public fun build(): ClaimOptions = ClaimOptions(accepts = accepts, jobClaimTimeoutMs = jobClaimTimeoutMs, heldJobStallMs = heldJobStallMs, heldJobStallCheckMs = heldJobStallCheckMs, markCommitTimeoutMs = markCommitTimeoutMs)
    }

    public companion object {
        /** A builder of a `ClaimOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(accepts: kotlin.collections.List<JobFilter>): Builder = Builder(accepts)
    }
}
