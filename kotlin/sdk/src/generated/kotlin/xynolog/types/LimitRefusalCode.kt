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
 * `streams`: the principal already holds as many streams as its coefficient of `x-xynolog-limits.streamsPerPrincipal` allows. `emit-rate`: the principal's emits have used its bucket, whose rate and burst are its coefficient of `x-xynolog-limits.emitsPerPrincipal`, per gateway process. `unanswered-requests`: the client already awaits as many replies as `BusSubscribeRequest.pendingReplies` may name. `capacity`: the gateway holds as many queued bytes as it can. `refusal-rate`: the request's credential was refused, and the requests its holder has had refused have used their allowance; it answers only a request whose token has already failed verification, so it says what a 401 says, and a client that can renew its token renews it and sends the request again rather than waiting (contract/TRANSPORT-CONTRACT.md § A refused credential).
 */
@Serializable
public enum class LimitRefusalCode(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("streams")
    Streams("streams"),

    @SerialName("emit-rate")
    EmitRate("emit-rate"),

    @SerialName("unanswered-requests")
    UnansweredRequests("unanswered-requests"),

    @SerialName("capacity")
    Capacity("capacity"),

    @SerialName("refusal-rate")
    RefusalRate("refusal-rate"),
}
