// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for mark:archived domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class ResourceArchivedPayload(
    public val reason: String? = null,
) {
    /** How Java makes a `ResourceArchivedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var reason: String? = null

        public fun reason(reason: String?): Builder = apply { this.reason = reason }

        public fun build(): ResourceArchivedPayload = ResourceArchivedPayload(reason = reason)
    }

    public companion object {
        /** A builder of a `ResourceArchivedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
