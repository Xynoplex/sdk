// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * The payload of `smelt:settled`: the Smelter's decision for one resource's content, keyed by the checksum of the bytes it inspected. `indexed`: the content is in the vector index. `skipped`: it declined, and `reason` says why.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class SmeltSettled(
    /**
     * The resource whose content was inspected.
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * The checksum of the bytes inspected.
     */
    @SerialName("contentChecksum")
    public val contentChecksum: String,
    @SerialName("outcome")
    public val outcome: SmeltSettledOutcome,
    /**
     * Why the content was skipped.
     */
    @SerialName("reason")
    public val reason: SmeltSettledReason? = null,
) {
    /** How Java makes a `SmeltSettled`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val contentChecksum: String,
        private val outcome: SmeltSettledOutcome,
    ) {
        private var reason: SmeltSettledReason? = null

        public fun reason(reason: SmeltSettledReason?): Builder {
            this.reason = reason
            return this
        }

        public fun build(): SmeltSettled = SmeltSettled(resourceId = resourceId, contentChecksum = contentChecksum, outcome = outcome, reason = reason)
    }

    public companion object {
        /** A builder of a `SmeltSettled` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, contentChecksum: String, outcome: SmeltSettledOutcome): Builder = Builder(resourceId, contentChecksum, outcome)
    }
}
