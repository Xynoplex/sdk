// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Loading the resource content. */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobProgressLoading(
    @EncodeDefault
    public val code: JobProgressLoadingCode = JobProgressLoadingCode.Loading,
) : JobProgressMessage {
    /** How Java makes a `JobProgressLoading`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        public fun build(): JobProgressLoading = JobProgressLoading()
    }

    public companion object {
        /** A builder of a `JobProgressLoading` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
