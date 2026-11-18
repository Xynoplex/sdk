// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonObject

/** A human participant — the Person branch of Agent. */
@Serializable(with = AgentPerson.Serializer::class)
public data class AgentPerson(
    @SerialName("@type")
    @EncodeDefault
    public val type: AgentPersonType = AgentPersonType.Person,
    /** DID-shaped identifier (e.g. did:web:host:users:email%40host) */
    @SerialName("@id")
    public val id: String? = null,
    /** Display name. ABSENT until resolved: a Person is identified by `@id` and nothing else, and what they are called is recorded once per change on the knowledge base's own log and filled in when a record is read. An artifact therefore never freezes a name, which is what lets a correction reach every artifact its subject ever wrote. Absent also means genuinely unknown — a DID this knowledge base has no profile for. */
    public val name: String? = null,
    public val nickname: String? = null,
    public val email: String? = null,
    @SerialName("email_sha1")
    public val emailSha1: String? = null,
    public val homepage: String? = null,
    /** Every property the schema does not name, as it came. */
    public val rest: JsonObject = JsonObject(emptyMap()),
) : Agent {
    /** How Java makes a `AgentPerson`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var id: String? = null
        private var name: String? = null
        private var nickname: String? = null
        private var email: String? = null
        private var emailSha1: String? = null
        private var homepage: String? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun id(id: String?): Builder = apply { this.id = id }
        public fun name(name: String?): Builder = apply { this.name = name }
        public fun nickname(nickname: String?): Builder = apply { this.nickname = nickname }
        public fun email(email: String?): Builder = apply { this.email = email }
        public fun emailSha1(emailSha1: String?): Builder = apply { this.emailSha1 = emailSha1 }
        public fun homepage(homepage: String?): Builder = apply { this.homepage = homepage }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): AgentPerson = AgentPerson(id = id, name = name, nickname = nickname, email = email, emailSha1 = emailSha1, homepage = homepage, rest = rest)
    }

    public companion object {
        /** A builder of a `AgentPerson` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }

    @Serializable
    internal data class Known(
        @SerialName("@type")
        @EncodeDefault
        public val type: AgentPersonType = AgentPersonType.Person,
        /** DID-shaped identifier (e.g. did:web:host:users:email%40host) */
        @SerialName("@id")
        public val id: String? = null,
        /** Display name. ABSENT until resolved: a Person is identified by `@id` and nothing else, and what they are called is recorded once per change on the knowledge base's own log and filled in when a record is read. An artifact therefore never freezes a name, which is what lets a correction reach every artifact its subject ever wrote. Absent also means genuinely unknown — a DID this knowledge base has no profile for. */
        public val name: String? = null,
        public val nickname: String? = null,
        public val email: String? = null,
        @SerialName("email_sha1")
        public val emailSha1: String? = null,
        public val homepage: String? = null,
    )

    internal object Serializer : KSerializer<AgentPerson> {
        private val named: Set<String> = setOf("@type", "@id", "name", "nickname", "email", "email_sha1", "homepage")

        override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AgentPerson", Known.serializer().descriptor)

        override fun deserialize(decoder: Decoder): AgentPerson {
            val json = decoder as? JsonDecoder ?: throw SerializationException("a AgentPerson is read from JSON alone")
            val all = json.decodeJsonElement().jsonObject
            val known = json.json.decodeFromJsonElement(Known.serializer(), JsonObject(all.filterKeys { it in named }))
            return AgentPerson(type = known.type, id = known.id, name = known.name, nickname = known.nickname, email = known.email, emailSha1 = known.emailSha1, homepage = known.homepage, rest = JsonObject(all.filterKeys { it !in named }))
        }

        override fun serialize(encoder: Encoder, value: AgentPerson) {
            val json = encoder as? JsonEncoder ?: throw SerializationException("a AgentPerson is written as JSON alone")
            val known = json.json.encodeToJsonElement(Known.serializer(), Known(type = value.type, id = value.id, name = value.name, nickname = value.nickname, email = value.email, emailSha1 = value.emailSha1, homepage = value.homepage)).jsonObject
            json.encodeJsonElement(JsonObject(known + value.rest))
        }
    }
}
