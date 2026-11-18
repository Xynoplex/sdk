// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** Bus command to register a tag schema with the KB's runtime registry. Carried on the `frame:add-tag-schema` channel — Frame is the schema-layer flow that owns vocabulary writes. Most-recent registration of a given `schema.id` wins; the projection reflects the latest content. Identical re-registrations are silent; differing content overwrites and logs a warning. */
@Serializable
@JsonIgnoreUnknownKeys
public data class FrameAddTagSchemaCommand(
    public val schema: TagSchema,
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
) {
    /** How Java makes a `FrameAddTagSchemaCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val schema: TagSchema,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): FrameAddTagSchemaCommand = FrameAddTagSchemaCommand(schema = schema, userId = userId)
    }

    public companion object {
        /** A builder of a `FrameAddTagSchemaCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(schema: TagSchema): Builder = Builder(schema)
    }
}
