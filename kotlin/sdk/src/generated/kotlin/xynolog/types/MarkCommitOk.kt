// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Durability acknowledgement for a mark:commit batch: every annotation named by the command is in the event log at the moment this is emitted. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkCommitOk(
    /** What the commit persisted. */
    public val response: MarkCommitOkResponse,
) {
    /** How Java makes a `MarkCommitOk`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: MarkCommitOkResponse,
    ) {
        public fun build(): MarkCommitOk = MarkCommitOk(response = response)
    }

    public companion object {
        /** A builder of a `MarkCommitOk` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: MarkCommitOkResponse): Builder = Builder(response)
    }
}
