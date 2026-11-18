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
 * Optional configuration for an annotation-focus gather, which windows text around a mark. Distinct from the resource-focus options (depth / maxResources / includeContent / includeSummary), which traverse the resource graph.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class GatherAnnotationOptions(
    /**
     * Whether to include source context in the gathered result
     */
    @SerialName("includeSourceContext")
    public val includeSourceContext: Boolean? = null,
    /**
     * Whether to include target context in the gathered result
     */
    @SerialName("includeTargetContext")
    public val includeTargetContext: Boolean? = null,
    /**
     * How much of the text on each side of the annotation to include, counted in Unicode code points
     */
    @SerialName("contextWindow")
    public val contextWindow: Long? = null,
) {
    /** How Java makes a `GatherAnnotationOptions`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var includeSourceContext: Boolean? = null
        private var includeTargetContext: Boolean? = null
        private var contextWindow: Long? = null

        public fun includeSourceContext(includeSourceContext: Boolean?): Builder {
            this.includeSourceContext = includeSourceContext
            return this
        }

        public fun includeTargetContext(includeTargetContext: Boolean?): Builder {
            this.includeTargetContext = includeTargetContext
            return this
        }

        public fun contextWindow(contextWindow: Long?): Builder {
            this.contextWindow = contextWindow
            return this
        }

        public fun build(): GatherAnnotationOptions = GatherAnnotationOptions(includeSourceContext = includeSourceContext, includeTargetContext = includeTargetContext, contextWindow = contextWindow)
    }

    public companion object {
        /** A builder of a `GatherAnnotationOptions` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }
}
