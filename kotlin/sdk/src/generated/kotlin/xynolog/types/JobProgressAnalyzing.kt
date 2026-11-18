// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Analyzing the content. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressAnalyzing(
    @EncodeDefault
    public val code: JobProgressAnalyzingCode = JobProgressAnalyzingCode.Analyzing,
) : JobProgressMessage {
    /** How Java makes a `JobProgressAnalyzing`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): JobProgressAnalyzing = JobProgressAnalyzing()
    }

    public companion object {
        /** A builder of a `JobProgressAnalyzing` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
