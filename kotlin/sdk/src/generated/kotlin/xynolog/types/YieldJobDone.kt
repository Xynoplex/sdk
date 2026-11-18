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
 * What a `yield` job reports when it has made its resource. The worker creates the resource first (the create round trip returns its id), then emits job:complete carrying it, so resourceId is always present on the wire.
 */
@Serializable
public data class YieldJobDone(
    /**
     * ID of the generated resource, obtained by the worker from the create round-trip before job:complete is emitted
     */
    @SerialName("resourceId")
    @get:JvmExposeBoxed
    public val resourceId: ResourceId,
    /**
     * Name of the generated resource
     */
    @SerialName("resourceName")
    public val resourceName: String,
    /**
     * True when the model stopped at the maxTokens ceiling — the artifact is cut off, not complete. Derived at the producer from the provider's stopReason ('max_tokens' → true); required because the worker always knows.
     */
    @SerialName("truncated")
    public val truncated: Boolean,
) : JobResult,
    YieldJobResult {
    /** How Java makes a `YieldJobDone`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resourceId: ResourceId,
        private val resourceName: String,
        private val truncated: Boolean,
    ) {
        public fun build(): YieldJobDone = YieldJobDone(resourceId = resourceId, resourceName = resourceName, truncated = truncated)
    }

    public companion object {
        /** A builder of a `YieldJobDone` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(resourceId: ResourceId, resourceName: String, truncated: Boolean): Builder = Builder(resourceId, resourceName, truncated)
    }
}
