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
 * Discriminant, sharing the `kind` field with the ExtractedText/ExtractionDeclined members so the whole answer is one flat union.
 *
 * `not-yet` — the resource's media type has text that is derived by reading its content, and the store holds no entry for this content: the Smelter has not read it yet, or the entry was lost (a loss the Smelter's reconcile pass re-derives). RETRY.
 *
 * `no-map` — the resource's media type has no derived text, so no entry exists and none will until the type is given a reader. Decided by the media type alone, and answered at once. TERMINAL.
 *
 * `unknown` — no content identity to look up: the resource is not in the view store, or its primary representation carries no checksum. TERMINAL.
 */
@Serializable
public enum class AnchoredTextAbsentKind(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("not-yet")
    NotYet("not-yet"),

    @SerialName("no-map")
    NoMap("no-map"),

    @SerialName("unknown")
    Unknown("unknown"),
}
