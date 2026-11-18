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
public data class TextQuoteSelector(
    @SerialName("type")
    @EncodeDefault
    public val type: TextQuoteSelectorType = TextQuoteSelectorType.TextQuoteSelector,
    @SerialName("exact")
    public val exact: String,
    @SerialName("prefix")
    public val prefix: String? = null,
    @SerialName("suffix")
    public val suffix: String? = null,
) : Selector {
    /** How Java makes a `TextQuoteSelector`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val exact: String,
    ) {
        private var prefix: String? = null
        private var suffix: String? = null

        public fun prefix(prefix: String?): Builder {
            this.prefix = prefix
            return this
        }

        public fun suffix(suffix: String?): Builder {
            this.suffix = suffix
            return this
        }

        public fun build(): TextQuoteSelector = TextQuoteSelector(exact = exact, prefix = prefix, suffix = suffix)
    }

    public companion object {
        /** A builder of a `TextQuoteSelector` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(exact: String): Builder = Builder(exact)
    }
}
