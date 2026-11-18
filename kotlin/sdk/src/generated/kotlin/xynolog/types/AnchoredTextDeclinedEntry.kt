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
 * The bytes were declined: no text is extracted from them.
 */
@Serializable
public data class AnchoredTextDeclinedEntry(
    /**
     * The entry format.
     */
    @SerialName("v")
    public val v: Long,
    /**
     * The stamp the entry was derived under: the PDF reader's and the OCR engine's. A reader takes the entry only when it equals the stamp the Smelter last stated.
     */
    @SerialName("stamp")
    public val stamp: String,
    /**
     * Why extraction yielded nothing, by class.
     */
    @SerialName("declined")
    public val declined: AnchoredTextDeclinedEntryDeclined,
) : AnchoredTextEntry {
    /** How Java makes a `AnchoredTextDeclinedEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val v: Long,
        private val stamp: String,
        private val declined: AnchoredTextDeclinedEntryDeclined,
    ) {
        public fun build(): AnchoredTextDeclinedEntry = AnchoredTextDeclinedEntry(v = v, stamp = stamp, declined = declined)
    }

    public companion object {
        /** A builder of a `AnchoredTextDeclinedEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(v: Long, stamp: String, declined: AnchoredTextDeclinedEntryDeclined): Builder = Builder(v, stamp, declined)
    }
}
