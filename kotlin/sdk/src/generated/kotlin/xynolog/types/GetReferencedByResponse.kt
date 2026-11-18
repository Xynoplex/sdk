// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetReferencedByResponse(
    public val referencedBy: kotlin.collections.List<GetReferencedByResponseReferencedByItem>,
) {
    /** How Java makes a `GetReferencedByResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val referencedBy: kotlin.collections.List<GetReferencedByResponseReferencedByItem>,
    ) {
        public fun build(): GetReferencedByResponse = GetReferencedByResponse(referencedBy = referencedBy)
    }

    public companion object {
        /** A builder of a `GetReferencedByResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(referencedBy: kotlin.collections.List<GetReferencedByResponseReferencedByItem>): Builder = Builder(referencedBy)
    }
}
