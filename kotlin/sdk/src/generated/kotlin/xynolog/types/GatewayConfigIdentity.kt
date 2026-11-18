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
 * The issuer this knowledge base trusts.
 */
@Serializable
public data class GatewayConfigIdentity(
    /**
     * The issuer URL, exactly as tokens carry it in `iss`.
     */
    @SerialName("issuer")
    public val issuer: String,
    /**
     * The claim a person's DID is built from: `did:web:<domain>:users:<its value>`.
     */
    @SerialName("subjectClaim")
    public val subjectClaim: String,
) {
    /** How Java makes a `GatewayConfigIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val issuer: String,
        private val subjectClaim: String,
    ) {
        public fun build(): GatewayConfigIdentity = GatewayConfigIdentity(issuer = issuer, subjectClaim = subjectClaim)
    }

    public companion object {
        /** A builder of a `GatewayConfigIdentity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(issuer: String, subjectClaim: String): Builder = Builder(issuer, subjectClaim)
    }
}
