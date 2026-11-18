// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Success reply after creating a yielded resource, matched to the originating command by correlationId. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldCreateOk(
    /** The created resource's identity. */
    public val response: YieldCreateOkResponse,
) {
    /** How Java makes a `YieldCreateOk`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val response: YieldCreateOkResponse,
    ) {
        public fun build(): YieldCreateOk = YieldCreateOk(response = response)
    }

    public companion object {
        /** A builder of a `YieldCreateOk` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(response: YieldCreateOkResponse): Builder = Builder(response)
    }
}
