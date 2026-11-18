// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class BrowseEnginesResultResponse(
    public val engines: kotlin.collections.List<EngineEntry>,
) {
    /** How Java makes a `BrowseEnginesResultResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engines: kotlin.collections.List<EngineEntry>,
    ) {
        public fun build(): BrowseEnginesResultResponse = BrowseEnginesResultResponse(engines = engines)
    }

    public companion object {
        /** A builder of a `BrowseEnginesResultResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engines: kotlin.collections.List<EngineEntry>): Builder = Builder(engines)
    }
}
