// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What a job does, as the verb that asks for it: `mark` annotates a resource, `yield` makes one. A job description is its `jobType` and the parameters that verb takes; a `mark` job's parameters state its motivation. */
@Serializable
public enum class JobType(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("mark")
    Mark("mark"),

    @SerialName("yield")
    Yield("yield"),
}
