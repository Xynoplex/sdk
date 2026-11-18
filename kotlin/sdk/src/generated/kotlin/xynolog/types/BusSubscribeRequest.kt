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
 * Subscription matrix for the bus stream. `global` channels are delivered unscoped; each `scoped` entry subscribes the connection to one resource scope's channels, optionally resuming from that scope's last-seen persisted event id. At least one global channel or one scoped entry is required, and no scope may appear in two entries.
 */
@Serializable
public data class BusSubscribeRequest(
    /**
     * Unscoped channels to subscribe to.
     */
    @SerialName("global")
    public val global: kotlin.collections.List<String>? = null,
    /**
     * Correlation ids of requests this client still awaits a reply to. The gateway writes every reply it still retains for them (for `x-xynolog-limits.replyRetentionSeconds` after it was published) as an ordinary frame with its ReplyEventId, so a reply that also arrived live dedups client-side. A client can have no more pending than it may have unanswered requests, so this bound is also the number of unanswered requests `POST /bus/emit` allows a client.
     */
    @SerialName("pendingReplies")
    public val pendingReplies: kotlin.collections.List<String>? = null,
    /**
     * Per-resource-scope subscriptions, at most 512 on one connection. Scopes must be unique across entries.
     */
    @SerialName("scoped")
    public val scoped: kotlin.collections.List<BusSubscribeRequestScopedItem>? = null,
    /**
     * Routing address for correlated replies: a UUID minted once per bus-client lifetime — per actor, not per connection, so it survives a reconnect and two overlapping connections share it. A correlated reply is delivered to a connection only when its request was emitted under the same clientId by the same principal. Not authentication — the bearer token stays that — and never echoed into any payload or broadcast frame.
     */
    @SerialName("clientId")
    public val clientId: String,
) {
    /** How Java makes a `BusSubscribeRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val clientId: String,
    ) {
        private var global: kotlin.collections.List<String>? = null
        private var pendingReplies: kotlin.collections.List<String>? = null
        private var scoped: kotlin.collections.List<BusSubscribeRequestScopedItem>? = null

        public fun global(global: kotlin.collections.List<String>?): Builder {
            this.global = global
            return this
        }

        public fun pendingReplies(pendingReplies: kotlin.collections.List<String>?): Builder {
            this.pendingReplies = pendingReplies
            return this
        }

        public fun scoped(scoped: kotlin.collections.List<BusSubscribeRequestScopedItem>?): Builder {
            this.scoped = scoped
            return this
        }

        public fun build(): BusSubscribeRequest = BusSubscribeRequest(global = global, pendingReplies = pendingReplies, scoped = scoped, clientId = clientId)
    }

    public companion object {
        /** A builder of a `BusSubscribeRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(clientId: String): Builder = Builder(clientId)
    }
}
