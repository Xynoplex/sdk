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

@Serializable
public data class BusSubscribeRequestScopedItem(
    /**
     * Resource scope (a resourceId).
     */
    @SerialName("scope")
    @get:JvmExposeBoxed
    public val scope: ResourceId,
    /**
     * Channels to subscribe within this scope.
     */
    @SerialName("channels")
    public val channels: kotlin.collections.List<String>,
    /**
     * This scope's last-seen PersistedEventId. The gateway replays this scope's persisted events after it — those on the entry's channels — before the live tail, and writes a scoped `bus:resume-gap` (BusResumeGap) when it cannot cover the gap.
     */
    @SerialName("lastEventId")
    public val lastEventId: String? = null,
) {
    /** How Java makes a `BusSubscribeRequestScopedItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val scope: ResourceId,
        private val channels: kotlin.collections.List<String>,
    ) {
        private var lastEventId: String? = null

        public fun lastEventId(lastEventId: String?): Builder {
            this.lastEventId = lastEventId
            return this
        }

        public fun build(): BusSubscribeRequestScopedItem = BusSubscribeRequestScopedItem(scope = scope, channels = channels, lastEventId = lastEventId)
    }

    public companion object {
        /** A builder of a `BusSubscribeRequestScopedItem` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(scope: ResourceId, channels: kotlin.collections.List<String>): Builder = Builder(scope, channels)
    }
}
