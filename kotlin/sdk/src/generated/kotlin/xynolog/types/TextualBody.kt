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
@JsonIgnoreUnknownKeys
public data class TextualBody(
    @SerialName("type")
    @EncodeDefault
    public val type: TextualBodyType = TextualBodyType.TextualBody,
    /**
     * The text content (e.g., entity type name)
     */
    @SerialName("value")
    public val value: String,
    /**
     * Why this body is included
     */
    @SerialName("purpose")
    public val purpose: BodyPurpose? = null,
    /**
     * MIME type (defaults to text/plain)
     */
    @SerialName("format")
    public val format: String? = null,
    /**
     * BCP 47 language tag
     */
    @SerialName("language")
    public val language: String? = null,
) : AnnotationBody {
    /** How Java makes a `TextualBody`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
    ) {
        private var purpose: BodyPurpose? = null
        private var format: String? = null
        private var language: String? = null

        public fun purpose(purpose: BodyPurpose?): Builder {
            this.purpose = purpose
            return this
        }

        public fun format(format: String?): Builder {
            this.format = format
            return this
        }

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun build(): TextualBody = TextualBody(value = value, purpose = purpose, format = format, language = language)
    }

    public companion object {
        /** A builder of a `TextualBody` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String): Builder = Builder(value)
    }
}
