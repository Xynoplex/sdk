// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The knowledge base said the resource does not exist. */
@Serializable
public data class TabCheckGone(
    /** What checking an open resource against its knowledge base concluded. */
    @EncodeDefault
    public val verdict: TabCheckGoneVerdict = TabCheckGoneVerdict.Gone,
) : TabCheck {
    /** How Java makes a `TabCheckGone`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): TabCheckGone = TabCheckGone()
    }

    public companion object {
        /** A builder of a `TabCheckGone` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
