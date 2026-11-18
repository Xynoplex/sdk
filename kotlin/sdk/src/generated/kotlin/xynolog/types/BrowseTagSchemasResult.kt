// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of browsing tag schemas */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseTagSchemasResult(
    public val response: GetTagSchemasResponse,
) {
    /** How Java makes a `BrowseTagSchemasResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: GetTagSchemasResponse,
    ) {
        public fun build(): BrowseTagSchemasResult = BrowseTagSchemasResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseTagSchemasResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: GetTagSchemasResponse): Builder = Builder(response)
    }
}
