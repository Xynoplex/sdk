// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** `starting`: signing in, opening its stream, confirming it, or waiting to start again. `working`: confirmed, its engines claiming. `refused`: refused, until the service is started again. */
@Serializable
public enum class WorkerKnowledgeBaseHealthState(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("starting")
    Starting("starting"),

    @SerialName("working")
    Working("working"),

    @SerialName("refused")
    Refused("refused"),
}
