// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A different knowledge base answered. Its did and the name it gave itself are here and nowhere else: the entry is as it was. */
@Serializable
public data class KbReadVerdictConflict(
    /** What reading the active knowledge base against its entry concluded. */
    @EncodeDefault
    public val kind: KbReadVerdictConflictKind = KbReadVerdictConflictKind.Conflict,
    /** The did the knowledge base that answered reported. */
    public val observedDid: String,
    /** The name the knowledge base that answered gave itself. */
    public val observedName: String,
) : KbReadVerdict {
    /** How Java makes a `KbReadVerdictConflict`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val observedDid: String,
        private val observedName: String,
    ) {
        public fun build(): KbReadVerdictConflict = KbReadVerdictConflict(observedDid = observedDid, observedName = observedName)
    }

    public companion object {
        /** A builder of a `KbReadVerdictConflict` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(observedDid: String, observedName: String): Builder = Builder(observedDid, observedName)
    }
}
