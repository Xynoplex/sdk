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
 * How a knowledge base is reached: a gateway over HTTP, or a knowledge base the host process has loaded. Told apart by `kind`. Only what builds a transport, or signs in at an issuer, reads it.
 */
@Serializable(with = KbEndpointSerializer::class)
public sealed interface KbEndpoint

internal object KbEndpointSerializer : JsonContentPolymorphicSerializer<KbEndpoint>(KbEndpoint::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.KbEndpoint", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<KbEndpoint> =
        when (((element as? JsonObject)?.get("kind") as? JsonPrimitive)?.content) {
            "http" -> HttpEndpoint.serializer()
            "local" -> LocalEndpoint.serializer()
            else -> throw SerializationException("a KbEndpoint states a `kind` that is one of `http`, `local`")
        }
}
