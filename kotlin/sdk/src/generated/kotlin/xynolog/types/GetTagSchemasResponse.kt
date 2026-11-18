// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetTagSchemasResponse(
    public val tagSchemas: kotlin.collections.List<TagSchema>,
) {
    /** How Java makes a `GetTagSchemasResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val tagSchemas: kotlin.collections.List<TagSchema>,
    ) {
        public fun build(): GetTagSchemasResponse = GetTagSchemasResponse(tagSchemas = tagSchemas)
    }

    public companion object {
        /** A builder of a `GetTagSchemasResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(tagSchemas: kotlin.collections.List<TagSchema>): Builder = Builder(tagSchemas)
    }
}
