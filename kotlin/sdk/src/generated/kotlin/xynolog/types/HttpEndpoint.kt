// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** A knowledge base reached through its gateway, over HTTP. The gateway's origin is the protocol, the host in lowercase and the port; a host that is not a host's name is refused before it is put into a URL (specs/src/session/gateway-url-cases.json). */
@Serializable
@JsonIgnoreUnknownKeys
public data class HttpEndpoint(
    /** Discriminant: the endpoint is a gateway reached over HTTP. */
    @EncodeDefault
    public val kind: HttpEndpointKind = HttpEndpointKind.Http,
    /** The gateway's host, as a person or a discovery document gave it. */
    public val host: String,
    /** The gateway's port. */
    public val port: Long,
    /** What the gateway is reached over. */
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
