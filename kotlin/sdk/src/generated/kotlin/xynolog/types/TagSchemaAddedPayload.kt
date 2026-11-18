// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for frame:tag-schema-added domain event (system-level, no resourceId — fan-out is global to the KB). */
@Serializable
@JsonIgnoreUnknownKeys
public data class TagSchemaAddedPayload(
    public val schema: TagSchema,
) {
    /** How Java makes a `TagSchemaAddedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val schema: TagSchema,
    ) {
        public fun build(): TagSchemaAddedPayload = TagSchemaAddedPayload(schema = schema)
    }

    public companion object {
        /** A builder of a `TagSchemaAddedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(schema: TagSchema): Builder = Builder(schema)
    }
}
