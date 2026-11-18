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
 * Where to connect to a knowledge base: an endpoint, and the labels a client keeps of it. It carries no identity: which knowledge base answers at an address is known only once it has been reached with a token and asked, so a target is what every caller can build before then, and a session's whole input. A client keeps it locally; it is never sent.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class KbTarget(
    /**
     * The key the client stores a session's credentials under. Two sessions that share one storage have two ids, or each overwrites the other's tokens. Whoever builds the target chooses it; none is made up.
     */
    @SerialName("id")
    public val id: String,
    /**
     * What a person reads the knowledge base as. Once the knowledge base has described itself, its own name.
     */
    @SerialName("label")
    public val label: String,
    @SerialName("endpoint")
    public val endpoint: KbEndpoint,
) {
    /** How Java makes a `KbTarget`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val label: String,
        private val endpoint: KbEndpoint,
    ) {
        public fun build(): KbTarget = KbTarget(id = id, label = label, endpoint = endpoint)
    }

    public companion object {
        /** A builder of a `KbTarget` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, label: String, endpoint: KbEndpoint): Builder = Builder(id, label, endpoint)
    }
}
