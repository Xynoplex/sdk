// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** The knowledge base's engines: those its Inference document names, and the jobs it has each used for */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseEnginesResult(
    public val response: BrowseEnginesResultResponse,
) {
    /** How Java makes a `BrowseEnginesResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: BrowseEnginesResultResponse,
    ) {
        public fun build(): BrowseEnginesResult = BrowseEnginesResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseEnginesResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: BrowseEnginesResultResponse): Builder = Builder(response)
    }
}
