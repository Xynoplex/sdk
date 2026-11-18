// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import xynolog.identifiers.ResourceId

/** The payload of `smelt:settled`: the Smelter's decision for one resource's content, keyed by the checksum of the bytes it inspected. `indexed`: the content is in the vector index. `skipped`: it declined, and `reason` says why. */
@Serializable
@JsonIgnoreUnknownKeys
public data class SmeltSettled(
    /** The resource whose content was inspected. */
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /** The checksum of the bytes inspected. */
    public val contentChecksum: String,
    public val outcome: SmeltSettledOutcome,
    /** Why the content was skipped. */
    public val reason: SmeltSettledReason? = null,
) {
    /** How Java makes a `SmeltSettled`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val contentChecksum: String,
        private val outcome: SmeltSettledOutcome,
    ) {
        private var reason: SmeltSettledReason? = null

        public fun reason(reason: SmeltSettledReason?): Builder = apply { this.reason = reason }

        public fun build(): SmeltSettled = SmeltSettled(resourceId = resourceId, contentChecksum = contentChecksum, outcome = outcome, reason = reason)
    }

    public companion object {
        /** A builder of a `SmeltSettled` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, contentChecksum: String, outcome: SmeltSettledOutcome): Builder = Builder(resourceId, contentChecksum, outcome)
    }
}
