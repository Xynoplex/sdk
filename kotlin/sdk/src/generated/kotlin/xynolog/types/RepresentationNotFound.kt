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
 * The Archivist's 404 for a resource's bytes: an ErrorResponse whose `code` says which half of the lookup failed — `resource` when the record holds no such resource, `representation` when it holds the resource but not its bytes. Each reader answers the two differently.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class RepresentationNotFound(
    /**
     * What went wrong, in a sentence.
     */
    @SerialName("error")
    public val error: String,
    @SerialName("code")
    public val code: RepresentationNotFoundCode,
    /**
     * What the caller can do about it, when there is something to say.
     */
    @SerialName("hint")
    public val hint: String? = null,
    @SerialName("details")
    public val details: JsonElement? = null,
) {
    /** How Java makes a `RepresentationNotFound`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val error: String,
        private val code: RepresentationNotFoundCode,
    ) {
        private var hint: String? = null
        private var details: JsonElement? = null

        public fun hint(hint: String?): Builder {
            this.hint = hint
            return this
        }

        public fun details(details: JsonElement?): Builder {
            this.details = details
            return this
        }

        public fun build(): RepresentationNotFound = RepresentationNotFound(error = error, code = code, hint = hint, details = details)
    }

    public companion object {
        /** A builder of a `RepresentationNotFound` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(error: String, code: RepresentationNotFoundCode): Builder = Builder(error, code)
    }
}
