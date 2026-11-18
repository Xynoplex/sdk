// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Bus command to request cloning a resource using a clone token. */
@Serializable
@JsonIgnoreUnknownKeys
public data class YieldCloneResourceRequest(
    public val token: String,
) {
    /** How Java makes a `YieldCloneResourceRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val token: String,
    ) {
        public fun build(): YieldCloneResourceRequest = YieldCloneResourceRequest(token = token)
    }

    public companion object {
        /** A builder of a `YieldCloneResourceRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(token: String): Builder = Builder(token)
    }
}
