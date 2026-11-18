// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** W3C Web Annotation FragmentSelector for media fragment identifiers (RFC 3778 for PDFs) */
@Serializable
@JsonIgnoreUnknownKeys
public data class FragmentSelector(
    @EncodeDefault
    public val type: FragmentSelectorType = FragmentSelectorType.FragmentSelector,
    /** Media fragment identifier (e.g., 'page=1&viewrect=100,200,50,30' for PDF) */
    public val value: String,
    /** URI identifying the fragment syntax specification */
    public val conformsTo: String? = null,
) : Selector {
    /** How Java makes a `FragmentSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
    ) {
        private var conformsTo: String? = null

        public fun conformsTo(conformsTo: String?): Builder = apply { this.conformsTo = conformsTo }

        public fun build(): FragmentSelector = FragmentSelector(value = value, conformsTo = conformsTo)
    }

    public companion object {
        /** A builder of a `FragmentSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String): Builder = Builder(value)
    }
}
