// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for yield:representation-added domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class RepresentationAddedPayload(
    public val representation: Representation,
) {
    /** How Java makes a `RepresentationAddedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val representation: Representation,
    ) {
        public fun build(): RepresentationAddedPayload = RepresentationAddedPayload(representation = representation)
    }

    public companion object {
        /** A builder of a `RepresentationAddedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(representation: Representation): Builder = Builder(representation)
    }
}
