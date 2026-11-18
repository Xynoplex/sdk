// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** What kind of answer this is: 'lexical' — the resources matched the query text; 'semantic' — no lexical match existed, and these resources discuss the query per the vector index. Required so every producer labels its answer; a UI can render semantic results as a different kind of page ('no title matches, but these documents discuss it'). */
@Serializable
public enum class MatchResourcesResponseMatchKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("lexical")
    Lexical("lexical"),

    @SerialName("semantic")
    Semantic("semantic"),
}
