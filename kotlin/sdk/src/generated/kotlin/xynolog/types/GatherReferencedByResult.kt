// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The annotations elsewhere that refer to a resource */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherReferencedByResult(
    public val response: GetReferencedByResponse,
) {
    /** How Java makes a `GatherReferencedByResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: GetReferencedByResponse,
    ) {
        public fun build(): GatherReferencedByResult = GatherReferencedByResult(response = response)
    }

    public companion object {
        /** A builder of a `GatherReferencedByResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: GetReferencedByResponse): Builder = Builder(response)
    }
}
