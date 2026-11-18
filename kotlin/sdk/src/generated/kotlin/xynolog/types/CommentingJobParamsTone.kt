// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** The voice the comments are written in. */
@Serializable
public enum class CommentingJobParamsTone(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("scholarly")
    Scholarly("scholarly"),

    @SerialName("explanatory")
    Explanatory("explanatory"),

    @SerialName("conversational")
    Conversational("conversational"),

    @SerialName("technical")
    Technical("technical"),
}
