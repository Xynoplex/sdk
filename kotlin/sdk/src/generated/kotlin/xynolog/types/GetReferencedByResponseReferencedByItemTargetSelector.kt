// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetReferencedByResponseReferencedByItemTargetSelector(
    /** The selected text that references this resource */
    public val exact: String,
) {
    /** How Java makes a `GetReferencedByResponseReferencedByItemTargetSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val exact: String,
    ) {
        public fun build(): GetReferencedByResponseReferencedByItemTargetSelector = GetReferencedByResponseReferencedByItemTargetSelector(exact = exact)
    }

    public companion object {
        /** A builder of a `GetReferencedByResponseReferencedByItemTargetSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(exact: String): Builder = Builder(exact)
    }
}
