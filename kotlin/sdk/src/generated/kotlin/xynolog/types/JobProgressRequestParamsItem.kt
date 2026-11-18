// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressRequestParamsItem(
    /** Which parameter this is. The client renders a localized name for it. */
    public val label: JobProgressRequestParamsItemLabel,
    /** The user's own input, shown verbatim. */
    public val value: String,
) {
    /** How Java makes a `JobProgressRequestParamsItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val label: JobProgressRequestParamsItemLabel,
        private val value: String,
    ) {
        public fun build(): JobProgressRequestParamsItem = JobProgressRequestParamsItem(label = label, value = value)
    }

    public companion object {
        /** A builder of a `JobProgressRequestParamsItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(label: JobProgressRequestParamsItemLabel, value: String): Builder = Builder(label, value)
    }
}
