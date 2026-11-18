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
 * Whole-resource focus.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusResource(
    @SerialName("kind")
    @EncodeDefault
    public val kind: GatheredContextFocusResourceKind = GatheredContextFocusResourceKind.Resource,
    /**
     * The resource this context was gathered for
     */
    @SerialName("resource")
    public val resource: ResourceDescriptor,
    @SerialName("summary")
    public val summary: String? = null,
    @SerialName("suggestedReferences")
    public val suggestedReferences: kotlin.collections.List<String>? = null,
    /**
     * Resource content (included when requested)
     */
    @SerialName("content")
    public val content: GatheredContextFocusResourceContent? = null,
) : GatheredContextFocus {
    /** How Java makes a `GatheredContextFocusResource`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resource: ResourceDescriptor,
    ) {
        private var summary: String? = null
        private var suggestedReferences: kotlin.collections.List<String>? = null
        private var content: GatheredContextFocusResourceContent? = null

        public fun summary(summary: String?): Builder {
            this.summary = summary
            return this
        }

        public fun suggestedReferences(suggestedReferences: kotlin.collections.List<String>?): Builder {
            this.suggestedReferences = suggestedReferences
            return this
        }

        public fun content(content: GatheredContextFocusResourceContent?): Builder {
            this.content = content
            return this
        }

        public fun build(): GatheredContextFocusResource = GatheredContextFocusResource(resource = resource, summary = summary, suggestedReferences = suggestedReferences, content = content)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusResource` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resource: ResourceDescriptor): Builder = Builder(resource)
    }
}
