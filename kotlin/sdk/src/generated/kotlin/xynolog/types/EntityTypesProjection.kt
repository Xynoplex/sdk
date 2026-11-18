// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The knowledge base's entity-type vocabulary: the file `projections/__system__/entitytypes.json` under the state directory, the sum of the `frame:entity-type-added` events. Written as JSON indented by two spaces. */
@Serializable
public data class EntityTypesProjection(
    /** Every entity type added, each once, sorted. */
    public val entityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `EntityTypesProjection`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        public fun build(): EntityTypesProjection = EntityTypesProjection(entityTypes = entityTypes)
    }

    public companion object {
        /** A builder of a `EntityTypesProjection` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityTypes: kotlin.collections.List<String>): Builder = Builder(entityTypes)
    }
}
