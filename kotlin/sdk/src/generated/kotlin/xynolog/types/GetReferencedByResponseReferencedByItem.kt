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
public data class GetReferencedByResponseReferencedByItem(
    /**
     * Reference annotation ID
     */
    @SerialName("id")
    @get:JvmExposeBoxed
    public val id: AnnotationId,
    /**
     * Name of the resource containing the reference. Absent where no description of that resource is held, and where its name is empty.
     */
    @SerialName("resourceName")
    public val resourceName: String? = null,
    @SerialName("target")
    public val target: GetReferencedByResponseReferencedByItemTarget,
) {
    /** How Java makes a `GetReferencedByResponseReferencedByItem`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: AnnotationId,
        private val target: GetReferencedByResponseReferencedByItemTarget,
    ) {
        private var resourceName: String? = null

        public fun resourceName(resourceName: String?): Builder {
            this.resourceName = resourceName
            return this
        }

        public fun build(): GetReferencedByResponseReferencedByItem = GetReferencedByResponseReferencedByItem(id = id, resourceName = resourceName, target = target)
    }

    public companion object {
        /** A builder of a `GetReferencedByResponseReferencedByItem` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(id: AnnotationId, target: GetReferencedByResponseReferencedByItemTarget): Builder = Builder(id, target)
    }
}
