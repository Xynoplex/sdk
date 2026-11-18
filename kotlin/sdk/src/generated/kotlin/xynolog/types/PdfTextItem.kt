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
 * One positioned text run. Coordinates are PDF points with the origin at the bottom-left of the page, Y increasing upward; the flip to canvas pixels happens in the browser.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class PdfTextItem(
    /**
     * Offset into AnchoredText.text, in Unicode code points from its start, inclusive.
     */
    @SerialName("start")
    public val start: Long,
    /**
     * Offset into AnchoredText.text, in Unicode code points from its start, exclusive.
     */
    @SerialName("end")
    public val end: Long,
    /**
     * 1-indexed page number.
     */
    @SerialName("page")
    public val page: Long,
    @SerialName("x")
    public val x: Double,
    @SerialName("y")
    public val y: Double,
    @SerialName("width")
    public val width: Double,
    @SerialName("height")
    public val height: Double,
) {
    /** How Java makes a `PdfTextItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val start: Long,
        private val end: Long,
        private val page: Long,
        private val x: Double,
        private val y: Double,
        private val width: Double,
        private val height: Double,
    ) {
        public fun build(): PdfTextItem = PdfTextItem(start = start, end = end, page = page, x = x, y = y, width = width, height = height)
    }

    public companion object {
        /** A builder of a `PdfTextItem` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(start: Long, end: Long, page: Long, x: Double, y: Double, width: Double, height: Double): Builder = Builder(start, end, page, x, y, width, height)
    }
}
