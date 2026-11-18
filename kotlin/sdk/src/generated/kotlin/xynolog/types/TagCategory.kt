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
 * A single category within a tag schema (e.g. 'Issue' in IRAC, 'distinguished' in legal-citation-treatment). Each category carries methodology-bound semantics: a name, a description, and examples used in the LLM prompt.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class TagCategory(
    @SerialName("name")
    public val name: String,
    @SerialName("description")
    public val description: String,
    @SerialName("examples")
    public val examples: kotlin.collections.List<String>,
) {
    /** How Java makes a `TagCategory`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
        private val description: String,
        private val examples: kotlin.collections.List<String>,
    ) {
        public fun build(): TagCategory = TagCategory(name = name, description = description, examples = examples)
    }

    public companion object {
        /** A builder of a `TagCategory` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String, description: String, examples: kotlin.collections.List<String>): Builder = Builder(name, description, examples)
    }
}
