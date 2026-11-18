// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A resource's descriptor, and the sequence number of the last of its events the descriptor reflects. Its annotations are not here: their number follows the document's, so they are read over HTTP (`GET /resources/{id}/annotations`). */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseResourceResult(
    public val response: BrowseResourceResultResponse,
) {
    /** How Java makes a `BrowseResourceResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: BrowseResourceResultResponse,
    ) {
        public fun build(): BrowseResourceResult = BrowseResourceResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseResourceResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: BrowseResourceResultResponse): Builder = Builder(response)
    }
}
