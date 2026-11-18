// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class StatusResponseFeatures(
    public val semanticContent: String,
    public val collaboration: String,
) {
    /** How Java makes a `StatusResponseFeatures`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val semanticContent: String,
        private val collaboration: String,
    ) {
        public fun build(): StatusResponseFeatures = StatusResponseFeatures(semanticContent = semanticContent, collaboration = collaboration)
    }

    public companion object {
        /** A builder of a `StatusResponseFeatures` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(semanticContent: String, collaboration: String): Builder = Builder(semanticContent, collaboration)
    }
}
