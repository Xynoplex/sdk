// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Xynolog-supported W3C Web Annotation motivations - https://www.w3.org/TR/annotation-vocab/#motivation */
@Serializable
public enum class Motivation(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("assessing")
    Assessing("assessing"),

    @SerialName("commenting")
    Commenting("commenting"),

    @SerialName("highlighting")
    Highlighting("highlighting"),

    @SerialName("linking")
    Linking("linking"),

    @SerialName("tagging")
    Tagging("tagging"),
}
