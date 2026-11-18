// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Success reply after creating an annotation, matched to the originating command by correlationId. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkCreateOk(
    public val response: MarkCreateOkResponse,
) {
    /** How Java makes a `MarkCreateOk`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: MarkCreateOkResponse,
    ) {
        public fun build(): MarkCreateOk = MarkCreateOk(response = response)
    }

    public companion object {
        /** A builder of a `MarkCreateOk` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: MarkCreateOkResponse): Builder = Builder(response)
    }
}
