// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Success reply after deleting an annotation, matched to the originating command by correlationId. */
@Serializable
@JsonIgnoreUnknownKeys
public data class MarkDeleteOk(
    /** The deleted annotation's identity. */
    public val response: MarkDeleteOkResponse,
) {
    /** How Java makes a `MarkDeleteOk`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: MarkDeleteOkResponse,
    ) {
        public fun build(): MarkDeleteOk = MarkDeleteOk(response = response)
    }

    public companion object {
        /** A builder of a `MarkDeleteOk` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: MarkDeleteOkResponse): Builder = Builder(response)
    }
}
