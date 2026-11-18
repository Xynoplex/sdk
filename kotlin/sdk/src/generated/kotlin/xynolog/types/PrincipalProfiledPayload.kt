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
 * Payload for principal:profiled — what this principal is called, as the issuer's verified `name` claim said or as the principal said of itself, recorded once per change (system-level, no resourceId). The event's `userId` is the principal's DID; this payload is the fact about it. Provenance never reads it: every artifact joins on the DID alone, and this is projected into profiles.json for readers to resolve against. Two lines for one DID mean the name changed, and the timestamps say when — which is why no artifact ever had to freeze a copy.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class PrincipalProfiledPayload(
    /**
     * The display name as of this event: from the issuer's verified `name` claim, or what the principal said of itself.
     */
    @SerialName("name")
    public val name: String,
) {
    /** How Java makes a `PrincipalProfiledPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
    ) {
        public fun build(): PrincipalProfiledPayload = PrincipalProfiledPayload(name = name)
    }

    public companion object {
        /** A builder of a `PrincipalProfiledPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String): Builder = Builder(name)
    }
}
