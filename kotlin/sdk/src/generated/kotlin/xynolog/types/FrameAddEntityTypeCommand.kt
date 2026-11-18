// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.UserId

/** Bus command to add a new entity type to the KB's vocabulary. Carried on the `frame:add-entity-type` channel — Frame is the schema-layer flow that owns vocabulary writes. */
@Serializable
@JsonIgnoreUnknownKeys
public data class FrameAddEntityTypeCommand(
    public val tag: String,
    /** Authenticated user's DID, injected by the /bus/emit gateway. Clients do not set this. */
    @SerialName("_userId")
    @get:JvmExposeBoxed
    public val userId: UserId? = null,
) {
    /** How Java makes a `FrameAddEntityTypeCommand`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val tag: String,
    ) {
        private var userId: UserId? = null

        @JvmExposeBoxed
        public fun userId(userId: UserId?): Builder = apply { this.userId = userId }

        public fun build(): FrameAddEntityTypeCommand = FrameAddEntityTypeCommand(tag = tag, userId = userId)
    }

    public companion object {
        /** A builder of a `FrameAddEntityTypeCommand` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(tag: String): Builder = Builder(tag)
    }
}
