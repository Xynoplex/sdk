// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for yield:moved domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceMovedPayload(
    /** Previous file:// URI */
    public val fromUri: String,
    /** New file:// URI */
    public val toUri: String,
) {
    /** How Java makes a `ResourceMovedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val fromUri: String,
        private val toUri: String,
    ) {
        public fun build(): ResourceMovedPayload = ResourceMovedPayload(fromUri = fromUri, toUri = toUri)
    }

    public companion object {
        /** A builder of a `ResourceMovedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(fromUri: String, toUri: String): Builder = Builder(fromUri, toUri)
    }
}
