// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of browsing annotation history */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseAnnotationHistoryResult(
    public val response: GetAnnotationHistoryResponse,
) {
    /** How Java makes a `BrowseAnnotationHistoryResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: GetAnnotationHistoryResponse,
    ) {
        public fun build(): BrowseAnnotationHistoryResult = BrowseAnnotationHistoryResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseAnnotationHistoryResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: GetAnnotationHistoryResponse): Builder = Builder(response)
    }
}
