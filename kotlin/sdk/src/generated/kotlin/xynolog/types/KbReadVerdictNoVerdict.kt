// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** It did not answer, or could not say who it is. Evidence of nothing. */
@Serializable
public data class KbReadVerdictNoVerdict(
    /** What reading the active knowledge base against its entry concluded. */
    @EncodeDefault
    public val kind: KbReadVerdictNoVerdictKind = KbReadVerdictNoVerdictKind.NoVerdict,
) : KbReadVerdict {
    /** How Java makes a `KbReadVerdictNoVerdict`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): KbReadVerdictNoVerdict = KbReadVerdictNoVerdict()
    }

    public companion object {
        /** A builder of a `KbReadVerdictNoVerdict` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
