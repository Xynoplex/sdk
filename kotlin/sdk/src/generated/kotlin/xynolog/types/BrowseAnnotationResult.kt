// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Result of browsing a single annotation */
@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseAnnotationResult(
    public val response: GetAnnotationResponse,
) {
    /** How Java makes a `BrowseAnnotationResult`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: GetAnnotationResponse,
    ) {
        public fun build(): BrowseAnnotationResult = BrowseAnnotationResult(response = response)
    }

    public companion object {
        /** A builder of a `BrowseAnnotationResult` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: GetAnnotationResponse): Builder = Builder(response)
    }
}
