// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of a job:create command */
@Serializable
@JsonIgnoreUnknownKeys
public data class JobCreatedResult(
    public val response: JobCreatedResultResponse,
) {
    /** How Java makes a `JobCreatedResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: JobCreatedResultResponse,
    ) {
        public fun build(): JobCreatedResult = JobCreatedResult(response = response)
    }

    public companion object {
        /** A builder of a `JobCreatedResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: JobCreatedResultResponse): Builder = Builder(response)
    }
}
