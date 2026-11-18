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
 * W3C Web Annotation FragmentSelector for media fragment identifiers (RFC 3778 for PDFs)
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class FragmentSelector(
    @SerialName("type")
    @EncodeDefault
    public val type: FragmentSelectorType = FragmentSelectorType.FragmentSelector,
    /**
     * Media fragment identifier (e.g., 'page=1&viewrect=100,200,50,30' for PDF)
     */
    @SerialName("value")
    public val value: String,
    /**
     * URI identifying the fragment syntax specification
     */
    @SerialName("conformsTo")
    public val conformsTo: String? = null,
) : Selector {
    /** How Java makes a `FragmentSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
    ) {
        private var conformsTo: String? = null

        public fun conformsTo(conformsTo: String?): Builder {
            this.conformsTo = conformsTo
            return this
        }

        public fun build(): FragmentSelector = FragmentSelector(value = value, conformsTo = conformsTo)
    }

    public companion object {
        /** A builder of a `FragmentSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String): Builder = Builder(value)
    }
}
