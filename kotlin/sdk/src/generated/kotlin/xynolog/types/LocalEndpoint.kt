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
 * A knowledge base the host process has loaded and reaches through a transport with no wire.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class LocalEndpoint(
    /**
     * Discriminant: the endpoint is in the host process.
     */
    @SerialName("kind")
    @EncodeDefault
    public val kind: LocalEndpointKind = LocalEndpointKind.Local,
    /**
     * Which loaded knowledge base, named by an id that means something to the host process alone.
     */
    @SerialName("kbId")
    public val kbId: String,
) : KbEndpoint {
    /** How Java makes a `LocalEndpoint`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val kbId: String,
    ) {
        public fun build(): LocalEndpoint = LocalEndpoint(kbId = kbId)
    }

    public companion object {
        /** A builder of a `LocalEndpoint` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(kbId: String): Builder = Builder(kbId)
    }
}
