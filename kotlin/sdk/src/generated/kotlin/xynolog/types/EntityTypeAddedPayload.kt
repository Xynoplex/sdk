// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for frame:entity-type-added domain event (system-level, no resourceId — fan-out is global) */
@Serializable
@JsonIgnoreUnknownKeys
public data class EntityTypeAddedPayload(
    public val entityType: String,
) {
    /** How Java makes a `EntityTypeAddedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityType: String,
    ) {
        public fun build(): EntityTypeAddedPayload = EntityTypeAddedPayload(entityType = entityType)
    }

    public companion object {
        /** A builder of a `EntityTypeAddedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityType: String): Builder = Builder(entityType)
    }
}
