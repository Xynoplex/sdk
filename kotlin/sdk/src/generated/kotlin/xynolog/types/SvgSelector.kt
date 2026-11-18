// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class SvgSelector(
    @EncodeDefault
    public val type: SvgSelectorType = SvgSelectorType.SvgSelector,
    /** SVG markup defining the region (must include xmlns attribute) */
    public val value: String,
) : Selector {
    /** How Java makes a `SvgSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
    ) {
        public fun build(): SvgSelector = SvgSelector(value = value)
    }

    public companion object {
        /** A builder of a `SvgSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String): Builder = Builder(value)
    }
}
