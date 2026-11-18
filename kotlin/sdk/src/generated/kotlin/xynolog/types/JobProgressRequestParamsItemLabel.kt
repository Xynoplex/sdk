// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** Which parameter this is. The client renders a localized name for it. */
@Serializable
public enum class JobProgressRequestParamsItemLabel(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("entity-types")
    EntityTypes("entity-types"),

    @SerialName("instructions")
    Instructions("instructions"),

    @SerialName("tone")
    Tone("tone"),

    @SerialName("density")
    Density("density"),
}
