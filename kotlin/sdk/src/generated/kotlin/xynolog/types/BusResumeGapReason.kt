// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** `unparseable-last-event-id`: the watermark is not a PersistedEventId. `scope-mismatch`: it names another scope. `retention-exceeded`: the record no longer holds the events after it (what it still holds is replayed first). `query-error`: the record could not be read. */
@Serializable
public enum class BusResumeGapReason(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("unparseable-last-event-id")
    UnparseableLastEventId("unparseable-last-event-id"),

    @SerialName("scope-mismatch")
    ScopeMismatch("scope-mismatch"),

    @SerialName("retention-exceeded")
    RetentionExceeded("retention-exceeded"),

    @SerialName("query-error")
    QueryError("query-error"),
}
