// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** It answered as that entry, and its name and branch are on the entry now. */
@Serializable
public data class KbReadVerdictRecorded(
    /** What reading the active knowledge base against its entry concluded. */
    @EncodeDefault
    public val kind: KbReadVerdictRecordedKind = KbReadVerdictRecordedKind.Recorded,
) : KbReadVerdict {
    /** How Java makes a `KbReadVerdictRecorded`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): KbReadVerdictRecorded = KbReadVerdictRecorded()
    }

    public companion object {
        /** A builder of a `KbReadVerdictRecorded` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
