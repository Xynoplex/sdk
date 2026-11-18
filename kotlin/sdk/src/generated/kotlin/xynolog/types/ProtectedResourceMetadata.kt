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
 * OAuth 2.0 Protected Resource Metadata (RFC 9728): which authorization server this knowledge base trusts, served at /.well-known/oauth-protected-resource so a client — the Browser, an MCP client — learns where to send a user to sign in without configuration. A 401 from any protected route points here in its WWW-Authenticate challenge.
 */
@Serializable
public data class ProtectedResourceMetadata(
    /**
     * This knowledge base's resource identifier: its did:web identity resolved to an https URL (did:web:example.github.io:my-kb identifies https://example.github.io/my-kb). This is the exact value a token's aud claim must carry. It is an identifier, not an address — nothing dereferences it, and a knowledge base reached over http in local development still names itself by the https form, which is what makes the value stable across every host, port and proxy it is reached through.
     */
    @SerialName("resource")
    public val resource: String,
    /**
     * Issuer identifiers whose tokens this resource accepts — the configured identity issuer.
     */
    @SerialName("authorization_servers")
    public val authorizationServers: kotlin.collections.List<String>,
    /**
     * How a bearer token reaches this resource: the Authorization header only.
     */
    @SerialName("bearer_methods_supported")
    public val bearerMethodsSupported: kotlin.collections.List<ProtectedResourceMetadataBearerMethodsSupportedItem>,
    /**
     * The knowledge base's name, for a client's sign-in prompt.
     */
    @SerialName("resource_name")
    public val resourceName: String? = null,
) {
    /** How Java makes a `ProtectedResourceMetadata`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resource: String,
        private val authorizationServers: kotlin.collections.List<String>,
        private val bearerMethodsSupported: kotlin.collections.List<ProtectedResourceMetadataBearerMethodsSupportedItem>,
    ) {
        private var resourceName: String? = null

        public fun resourceName(resourceName: String?): Builder {
            this.resourceName = resourceName
            return this
        }

        public fun build(): ProtectedResourceMetadata = ProtectedResourceMetadata(resource = resource, authorizationServers = authorizationServers, bearerMethodsSupported = bearerMethodsSupported, resourceName = resourceName)
    }

    public companion object {
        /** A builder of a `ProtectedResourceMetadata` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resource: String, authorizationServers: kotlin.collections.List<String>, bearerMethodsSupported: kotlin.collections.List<ProtectedResourceMetadataBearerMethodsSupportedItem>): Builder = Builder(resource, authorizationServers, bearerMethodsSupported)
    }
}
