// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** `mark` jobs of one motivation. */
@Serializable
public data class MarkJobFilter(
    @EncodeDefault
    public val jobType: MarkJobFilterJobType = MarkJobFilterJobType.Mark,
    public val params: MarkJobFilterParams,
) : JobFilter {
    /** How Java makes a `MarkJobFilter`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val params: MarkJobFilterParams,
    ) {
        public fun build(): MarkJobFilter = MarkJobFilter(params = params)
    }

    public companion object {
        /** A builder of a `MarkJobFilter` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(params: MarkJobFilterParams): Builder = Builder(params)
    }
}
