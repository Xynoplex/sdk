// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The knowledge base's tag schemas: the file `projections/__system__/tagschemas.json` under the state directory, the sum of the `frame:tag-schema-added` events. Written as JSON indented by two spaces. */
@Serializable
public data class TagSchemasProjection(
    /** Every tag schema added, sorted by `id`. A schema added again under an `id` replaces the one held. */
    public val tagSchemas: kotlin.collections.List<TagSchema>,
) {
    /** How Java makes a `TagSchemasProjection`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val tagSchemas: kotlin.collections.List<TagSchema>,
    ) {
        public fun build(): TagSchemasProjection = TagSchemasProjection(tagSchemas = tagSchemas)
    }

    public companion object {
        /** A builder of a `TagSchemasProjection` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(tagSchemas: kotlin.collections.List<TagSchema>): Builder = Builder(tagSchemas)
    }
}
