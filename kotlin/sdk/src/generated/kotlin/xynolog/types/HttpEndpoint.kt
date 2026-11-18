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
 * A knowledge base reached through its gateway, over HTTP. The gateway's origin is the protocol, the host in lowercase and the port; a host that is not a host's name is refused before it is put into a URL (specs/src/session/gateway-url-cases.json).
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class HttpEndpoint(
    /**
     * Discriminant: the endpoint is a gateway reached over HTTP.
     */
    @SerialName("kind")
    @EncodeDefault
    public val kind: HttpEndpointKind = HttpEndpointKind.Http,
    /**
     * The gateway's host, as a person or a discovery document gave it.
     */
    @SerialName("host")
    public val host: String,
    /**
     * The gateway's port.
     */
    @SerialName("port")
    public val port: Long,
    /**
     * What the gateway is reached over.
     */
    @SerialName("protocol")
    public val protocol: HttpEndpointProtocol,
) : KbEndpoint {
    /** How Java makes a `HttpEndpoint`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val host: String,
        private val port: Long,
        private val protocol: HttpEndpointProtocol,
    ) {
        public fun build(): HttpEndpoint = HttpEndpoint(host = host, port = port, protocol = protocol)
    }

    public companion object {
        /** A builder of a `HttpEndpoint` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(host: String, port: Long, protocol: HttpEndpointProtocol): Builder = Builder(host, port, protocol)
    }
}
