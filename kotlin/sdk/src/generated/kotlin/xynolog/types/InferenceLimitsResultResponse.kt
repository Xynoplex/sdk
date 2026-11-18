// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class InferenceLimitsResultResponse(
    public val limits: kotlin.collections.List<EngineLimits>,
) {
    /** How Java makes a `InferenceLimitsResultResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val limits: kotlin.collections.List<EngineLimits>,
    ) {
        public fun build(): InferenceLimitsResultResponse = InferenceLimitsResultResponse(limits = limits)
    }

    public companion object {
        /** A builder of a `InferenceLimitsResultResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(limits: kotlin.collections.List<EngineLimits>): Builder = Builder(limits)
    }
}
