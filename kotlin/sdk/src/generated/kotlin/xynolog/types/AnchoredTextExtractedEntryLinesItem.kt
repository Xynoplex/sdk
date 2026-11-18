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
 * One line of text: the words that share a page, a baseline and a height.
 */
@Serializable
public data class AnchoredTextExtractedEntryLinesItem(
    /**
     * The page, counted from 1.
     */
    @SerialName("p")
    public val p: Long,
    /**
     * The line's vertical position in PDF points, from the bottom of the page.
     */
    @SerialName("y")
    public val y: Double,
    /**
     * The line's height in PDF points.
     */
    @SerialName("h")
    public val h: Double,
    /**
     * Each word as `[x, width, start, end]`: its horizontal position and width in PDF points, and the offsets of its text in `text`, which are whole numbers of Unicode code points from the start of `text`.
     */
    @SerialName("words")
    public val words: kotlin.collections.List<kotlin.collections.List<Double>>,
) {
    /** How Java makes a `AnchoredTextExtractedEntryLinesItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val p: Long,
        private val y: Double,
        private val h: Double,
        private val words: kotlin.collections.List<kotlin.collections.List<Double>>,
    ) {
        public fun build(): AnchoredTextExtractedEntryLinesItem = AnchoredTextExtractedEntryLinesItem(p = p, y = y, h = h, words = words)
    }

    public companion object {
        /** A builder of a `AnchoredTextExtractedEntryLinesItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(p: Long, y: Double, h: Double, words: kotlin.collections.List<kotlin.collections.List<Double>>): Builder = Builder(p, y, h, words)
    }
}
