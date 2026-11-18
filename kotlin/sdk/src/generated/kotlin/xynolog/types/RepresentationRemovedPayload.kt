// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for yield:representation-removed domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class RepresentationRemovedPayload(
    /** Checksum of the representation to remove */
    public val checksum: String,
) {
    /** How Java makes a `RepresentationRemovedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val checksum: String,
    ) {
        public fun build(): RepresentationRemovedPayload = RepresentationRemovedPayload(checksum = checksum)
    }

    public companion object {
        /** A builder of a `RepresentationRemovedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(checksum: String): Builder = Builder(checksum)
    }
}
