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
 * Text paired with the geometry that indexes it — the minimum needed to turn a range of the text, two offsets counted in Unicode code points, into a selection, or a rectangle into a quote. Whole-resource: a producer iterates page by page, but every consumer wants one map.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnchoredText(
    /**
     * Reading-order text of the whole resource.
     */
    @SerialName("text")
    public val text: String,
    /**
     * Positioned runs indexing `text`, roughly one per word.
     */
    @SerialName("items")
    public val items: kotlin.collections.List<PdfTextItem>,
) {
    /** How Java makes a `AnchoredText`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val text: String,
        private val items: kotlin.collections.List<PdfTextItem>,
    ) {
        public fun build(): AnchoredText = AnchoredText(text = text, items = items)
    }

    public companion object {
        /** A builder of a `AnchoredText` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(text: String, items: kotlin.collections.List<PdfTextItem>): Builder = Builder(text, items)
    }
}
