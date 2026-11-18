// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetEntityTypesResponse(
    public val entityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `GetEntityTypesResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        public fun build(): GetEntityTypesResponse = GetEntityTypesResponse(entityTypes = entityTypes)
    }

    public companion object {
        /** A builder of a `GetEntityTypesResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityTypes: kotlin.collections.List<String>): Builder = Builder(entityTypes)
    }
}
