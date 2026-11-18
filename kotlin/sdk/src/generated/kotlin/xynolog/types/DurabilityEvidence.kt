// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** How a job's annotations were established as durable — the OBSERVATION, never a conclusion drawn from it. 'acknowledged': the event log confirmed the batch (mark:commit-ok). 'probe-confirmed': the acknowledgement was lost and a later read found the batch's last annotation present — true, but a weaker claim than an ack, since it rests on the log appending a batch in order and stopping at the first failure. 'probe-refused': the read returned a failure reply; note this does NOT assert the annotations are absent, because a read that failed for its own reasons answers on the same channel. 'probe-unreachable': no answer came at all, so nothing was established either way. ABSENT means the question never arose — a job that committed no annotations. Never defaulted: a manufactured value here is a claim nobody made, in a log nobody can rewrite. */
@Serializable
public enum class DurabilityEvidence(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("acknowledged")
    Acknowledged("acknowledged"),

    @SerialName("probe-confirmed")
    ProbeConfirmed("probe-confirmed"),

    @SerialName("probe-refused")
    ProbeRefused("probe-refused"),

    @SerialName("probe-unreachable")
    ProbeUnreachable("probe-unreachable"),
}
