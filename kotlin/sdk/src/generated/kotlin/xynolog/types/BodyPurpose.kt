// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** W3C Web Annotation body purpose vocabulary - https://www.w3.org/TR/annotation-vocab/#motivation */
@Serializable
public enum class BodyPurpose(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("assessing")
    Assessing("assessing"),

    @SerialName("bookmarking")
    Bookmarking("bookmarking"),

    @SerialName("classifying")
    Classifying("classifying"),

    @SerialName("commenting")
    Commenting("commenting"),

    @SerialName("describing")
    Describing("describing"),

    @SerialName("editing")
    Editing("editing"),

    @SerialName("highlighting")
    Highlighting("highlighting"),

    @SerialName("identifying")
    Identifying("identifying"),

    @SerialName("linking")
    Linking("linking"),

    @SerialName("moderating")
    Moderating("moderating"),

    @SerialName("questioning")
    Questioning("questioning"),

    @SerialName("replying")
    Replying("replying"),

    @SerialName("tagging")
    Tagging("tagging"),
}
