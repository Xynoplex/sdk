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
 * A registered knowledge base: a target, and what registering it took, the identity the knowledge base reported of itself when it was reached (`did`) among it. What a client's list of knowledge bases holds. A did says which knowledge base, not which running copy: a clone and a codespace of one repository are one knowledge base at two addresses and report one did. So an entry is looked up by its endpoint, and its did is what an answer is verified against; nothing selects by did. Its `label` and `lastRead` are written only from an answer that carried its did.
 */
@Serializable
@JsonIgnoreUnknownKeys
public data class KnowledgeBase(
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
    /**
     * The did the knowledge base reported of itself.
     */
    @SerialName("did")
    public val did: String,
    /**
     * The last time the knowledge base described itself. Absent until it has, in an answer that carried this entry's did.
     */
    @SerialName("lastRead")
    public val lastRead: KbRead? = null,
) {
    /** How Java makes a `KnowledgeBase`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val id: String,
        private val label: String,
        private val endpoint: KbEndpoint,
        private val did: String,
    ) {
        private var lastRead: KbRead? = null

        public fun lastRead(lastRead: KbRead?): Builder {
            this.lastRead = lastRead
            return this
        }

        public fun build(): KnowledgeBase = KnowledgeBase(id = id, label = label, endpoint = endpoint, did = did, lastRead = lastRead)
    }

    public companion object {
        /** A builder of a `KnowledgeBase` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(id: String, label: String, endpoint: KbEndpoint, did: String): Builder = Builder(id, label, endpoint, did)
    }
}
