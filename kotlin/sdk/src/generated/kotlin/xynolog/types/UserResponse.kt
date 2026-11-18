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
 * The authenticated principal, as this knowledge base names it.
 *
 * The `did` is the identity: it is what the bus stamps on every event, what resource creation is attributed to, and what a client must compare against to recognise its own work in the data. It is the only identifier: a row id would appear nowhere else in the system and correlate with nothing.
 *
 * The remaining fields exist to be displayed, and all of them come from the token's own claims.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class UserResponse(
    /**
     * The authenticated principal's DID: `did:web:<domain>:agents:<subject>` for an agent, whose token's `kind` claim is `agent`, and `did:web:<domain>:users:<subject>` for a person, where the subject is the issuer claim the knowledge base names its principals by (`identity.subjectClaim`).
     */
    @SerialName("did")
    @get:JvmExposeBoxed
    public val did: UserId,
    /**
     * The address the token carries, when it carries one: an agent's account need not have one.
     */
    @SerialName("email")
    public val email: String?,
    @SerialName("name")
    public val name: String?,
    @SerialName("image")
    public val image: String?,
    /**
     * The knowledge base's domain: the authority the principal is named under.
     */
    @SerialName("domain")
    public val domain: String,
) {
    /** How Java makes a `UserResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val did: UserId,
        private val email: String?,
        private val name: String?,
        private val image: String?,
        private val domain: String,
    ) {
        public fun build(): UserResponse = UserResponse(did = did, email = email, name = name, image = image, domain = domain)
    }

    public companion object {
        /** A builder of a `UserResponse` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(did: UserId, email: String?, name: String?, image: String?, domain: String): Builder = Builder(did, email, name, image, domain)
    }
}
