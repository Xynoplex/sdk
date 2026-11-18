// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** `yield` jobs. */
@Serializable
public data class YieldJobFilter(
    @EncodeDefault
    public val jobType: YieldJobFilterJobType = YieldJobFilterJobType.Yield,
) : JobFilter {
    /** How Java makes a `YieldJobFilter`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): YieldJobFilter = YieldJobFilter()
    }

    public companion object {
        /** A builder of a `YieldJobFilter` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
