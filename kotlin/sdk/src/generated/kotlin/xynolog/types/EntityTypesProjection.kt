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
 * The knowledge base's entity-type vocabulary: the file `projections/__system__/entitytypes.json` under the state directory, the sum of the `frame:entity-type-added` events. Written as JSON indented by two spaces.
 */
@Serializable
public data class EntityTypesProjection(
    /**
     * Every entity type added, each once, sorted.
     */
    @SerialName("entityTypes")
    public val entityTypes: kotlin.collections.List<String>,
) {
    /** How Java makes a `EntityTypesProjection`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val entityTypes: kotlin.collections.List<String>,
    ) {
        public fun build(): EntityTypesProjection = EntityTypesProjection(entityTypes = entityTypes)
    }

    public companion object {
        /** A builder of a `EntityTypesProjection` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(entityTypes: kotlin.collections.List<String>): Builder = Builder(entityTypes)
    }
}
