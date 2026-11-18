// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Semantics of this rendition relative to the resource (e.g., original, thumbnail, preview, derived). */
@Serializable
public enum class RepresentationRel(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("original")
    Original("original"),

    @SerialName("thumbnail")
    Thumbnail("thumbnail"),

    @SerialName("preview")
    Preview("preview"),

    @SerialName("optimized")
    Optimized("optimized"),

    @SerialName("derived")
    Derived("derived"),

    @SerialName("other")
    Other("other"),
}
