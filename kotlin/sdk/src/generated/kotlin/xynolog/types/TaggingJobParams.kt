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
 * What a tagging job takes: passages of the resource are marked with categories of one tag schema.
 */
@Serializable
public data class TaggingJobParams(
    @SerialName("motivation")
    @EncodeDefault
    public val motivation: TaggingJobParamsMotivation = TaggingJobParamsMotivation.Tagging,
    /**
     * The tag schema to tag by. It is one the knowledge base registers.
     */
    @SerialName("schemaId")
    public val schemaId: String,
    /**
     * The categories of that schema to tag with.
     */
    @SerialName("categories")
    public val categories: kotlin.collections.List<String>,
    /**
     * The language the annotations' own text is written in. BCP 47.
     */
    @SerialName("language")
    public val language: String? = null,
    /**
     * The language of the resource being read. BCP 47.
     */
    @SerialName("sourceLanguage")
    public val sourceLanguage: String? = null,
) : MarkJobParams {
    /** How Java makes a `TaggingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val schemaId: String,
        private val categories: kotlin.collections.List<String>,
    ) {
        private var language: String? = null
        private var sourceLanguage: String? = null

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun sourceLanguage(sourceLanguage: String?): Builder {
            this.sourceLanguage = sourceLanguage
            return this
        }

        public fun build(): TaggingJobParams = TaggingJobParams(schemaId = schemaId, categories = categories, language = language, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `TaggingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(schemaId: String, categories: kotlin.collections.List<String>): Builder = Builder(schemaId, categories)
    }
}
