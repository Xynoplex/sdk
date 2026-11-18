// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The keys of the entries the anchored-text store holds under the stamp last stated: one checksum for each set of bytes whose text is stored, in no order. */
@Serializable
public data class AnchoredTextEntries(
    public val checksums: kotlin.collections.List<String>,
) {
    /** How Java makes a `AnchoredTextEntries`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val checksums: kotlin.collections.List<String>,
    ) {
        public fun build(): AnchoredTextEntries = AnchoredTextEntries(checksums = checksums)
    }

    public companion object {
        /** A builder of a `AnchoredTextEntries` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(checksums: kotlin.collections.List<String>): Builder = Builder(checksums)
    }
}
