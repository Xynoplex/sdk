// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The bound on a search by meaning. */
@Serializable
public data class LibrarianConfigSearch(
    /** The least similarity a hit by meaning must have. */
    public val semanticFloor: Double,
) {
    /** How Java makes a `LibrarianConfigSearch`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val semanticFloor: Double,
    ) {
        public fun build(): LibrarianConfigSearch = LibrarianConfigSearch(semanticFloor = semanticFloor)
    }

    public companion object {
        /** A builder of a `LibrarianConfigSearch` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(semanticFloor: Double): Builder = Builder(semanticFloor)
    }
}
