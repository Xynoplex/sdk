// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What sort of thing `value` is. Adding a variant means adding client copy for it in every locale. */
@Serializable
public enum class JobProgressCurrentKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("entity-type")
    EntityType("entity-type"),

    @SerialName("category")
    Category("category"),
}
