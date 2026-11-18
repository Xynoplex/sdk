// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of a job status request */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobStatusResult(
    public val response: JobStatusResponse,
) {
    /** How Java makes a `JobStatusResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: JobStatusResponse,
    ) {
        public fun build(): JobStatusResult = JobStatusResult(response = response)
    }

    public companion object {
        /** A builder of a `JobStatusResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: JobStatusResponse): Builder = Builder(response)
    }
}
