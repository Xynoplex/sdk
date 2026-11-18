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
 * A participant opened a live connection to this KB — an SSE stream on /bus/subscribe. Presence is CONNECTION lifecycle, not login: a token can be minted and sit unused, so what this reports is that someone is WATCHING. One person with two tabs produces two of these, which is why connectionId is required — the DID alone cannot tell two connections apart, and a consumer that counts DIDs will undercount viewers.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class SessionJoinedEvent(
    /**
     * DID of the authenticated principal on that connection. A person or a software agent — the bus does not distinguish.
     */
    @SerialName("participant")
    @get:JvmExposeBoxed
    public val participant: UserId,
    /**
     * Identifies this connection for its lifetime. The matching session:left carries the same value.
     */
    @SerialName("connectionId")
    public val connectionId: String,
) {
    /** How Java makes a `SessionJoinedEvent`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val participant: UserId,
        private val connectionId: String,
    ) {
        public fun build(): SessionJoinedEvent = SessionJoinedEvent(participant = participant, connectionId = connectionId)
    }

    public companion object {
        /** A builder of a `SessionJoinedEvent` that states these, and what its setters add. */
        @JvmStatic
        @JvmExposeBoxed
        public fun builder(participant: UserId, connectionId: String): Builder = Builder(participant, connectionId)
    }
}
