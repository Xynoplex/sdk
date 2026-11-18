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
 * What a commenting job takes: passages of the resource are marked, each with a comment the model writes.
 */
@Serializable
public data class CommentingJobParams(
    @SerialName("motivation")
    @EncodeDefault
    public val motivation: CommentingJobParamsMotivation = CommentingJobParamsMotivation.Commenting,
    /**
     * What to look for, in the caller's words. Added to the prompt.
     */
    @SerialName("instructions")
    public val instructions: String? = null,
    /**
     * The voice the comments are written in.
     */
    @SerialName("tone")
    public val tone: CommentingJobParamsTone? = null,
    /**
     * How many annotations to aim for per 2000 words of the resource.
     */
    @SerialName("density")
    public val density: Double? = null,
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
    /** How Java makes a `CommentingJobParams`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var instructions: String? = null
        private var tone: CommentingJobParamsTone? = null
        private var density: Double? = null
        private var language: String? = null
        private var sourceLanguage: String? = null

        public fun instructions(instructions: String?): Builder {
            this.instructions = instructions
            return this
        }

        public fun tone(tone: CommentingJobParamsTone?): Builder {
            this.tone = tone
            return this
        }

        public fun density(density: Double?): Builder {
            this.density = density
            return this
        }

        public fun language(language: String?): Builder {
            this.language = language
            return this
        }

        public fun sourceLanguage(sourceLanguage: String?): Builder {
            this.sourceLanguage = sourceLanguage
            return this
        }

        public fun build(): CommentingJobParams = CommentingJobParams(instructions = instructions, tone = tone, density = density, language = language, sourceLanguage = sourceLanguage)
    }

    public companion object {
        /** A builder of a `CommentingJobParams` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
