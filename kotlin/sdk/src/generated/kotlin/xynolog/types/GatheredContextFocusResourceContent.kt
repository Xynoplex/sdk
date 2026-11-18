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
 * Resource content (included when requested)
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatheredContextFocusResourceContent(
    /**
     * Content of the focal resource
     */
    @SerialName("main")
    public val main: String? = null,
    /**
     * Map of related resource IDs to their content
     */
    @SerialName("related")
    public val related: kotlin.collections.Map<String, String>? = null,
) {
    /** How Java makes a `GatheredContextFocusResourceContent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var main: String? = null
        private var related: kotlin.collections.Map<String, String>? = null

        public fun main(main: String?): Builder {
            this.main = main
            return this
        }

        public fun related(related: kotlin.collections.Map<String, String>?): Builder {
            this.related = related
            return this
        }

        public fun build(): GatheredContextFocusResourceContent = GatheredContextFocusResourceContent(main = main, related = related)
    }

    public companion object {
        /** A builder of a `GatheredContextFocusResourceContent` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
