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
 * The payload of `bus:resume-gap`: a scope's `lastEventId` could not be honoured, so the client cannot trust that it has every persisted event of that scope and must refetch what it caches for it. Written by the gateway, never by a participant.
 */
@Serializable
public data class BusResumeGap(
    /**
     * The scope of the subscription entry whose watermark failed.
     */
    @SerialName("scope")
    @get:JvmExposeBoxed
    public val scope: ResourceId,
    /**
     * The watermark the entry carried.
     */
    @SerialName("lastSeenId")
    public val lastSeenId: String,
    /**
     * `unparseable-last-event-id`: the watermark is not a PersistedEventId. `scope-mismatch`: it names another scope. `retention-exceeded`: the record no longer holds the events after it (what it still holds is replayed first). `query-error`: the record could not be read.
     */
    @SerialName("reason")
    public val reason: BusResumeGapReason,
) {
    /** How Java makes a `BusResumeGap`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val scope: ResourceId,
        private val lastSeenId: String,
        private val reason: BusResumeGapReason,
    ) {
        public fun build(): BusResumeGap = BusResumeGap(scope = scope, lastSeenId = lastSeenId, reason = reason)
    }

    public companion object {
        /** A builder of a `BusResumeGap` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(scope: ResourceId, lastSeenId: String, reason: BusResumeGapReason): Builder = Builder(scope, lastSeenId, reason)
    }
}
