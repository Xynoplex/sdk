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

/** An organization — the Organization branch of Agent. */
@Serializable(with = AgentOrganization.Serializer::class)
public data class AgentOrganization(
    @SerialName("@type")
    @EncodeDefault
    public val type: AgentOrganizationType = AgentOrganizationType.Organization,
    @SerialName("@id")
    public val id: String? = null,
    public val name: String,
    public val homepage: String? = null,
    /** Every property the schema does not name, as it came. */
    public val rest: JsonObject = JsonObject(emptyMap()),
) : Agent {
    /** How Java makes a `AgentOrganization`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val name: String,
    ) {
        private var id: String? = null
        private var homepage: String? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun id(id: String?): Builder = apply { this.id = id }
        public fun homepage(homepage: String?): Builder = apply { this.homepage = homepage }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): AgentOrganization = AgentOrganization(id = id, name = name, homepage = homepage, rest = rest)
    }

    public companion object {
        /** A builder of a `AgentOrganization` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(name: String): Builder = Builder(name)
    }

    @Serializable
    internal data class Known(
        @SerialName("@type")
        @EncodeDefault
        public val type: AgentOrganizationType = AgentOrganizationType.Organization,
        @SerialName("@id")
        public val id: String? = null,
        public val name: String,
        public val homepage: String? = null,
    )

    internal object Serializer : KSerializer<AgentOrganization> {
        private val named: Set<String> = setOf("@type", "@id", "name", "homepage")

        override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AgentOrganization", Known.serializer().descriptor)

        override fun deserialize(decoder: Decoder): AgentOrganization {
            val json = decoder as? JsonDecoder ?: throw SerializationException("a AgentOrganization is read from JSON alone")
            val all = json.decodeJsonElement().jsonObject
            val known = json.json.decodeFromJsonElement(Known.serializer(), JsonObject(all.filterKeys { it in named }))
            return AgentOrganization(type = known.type, id = known.id, name = known.name, homepage = known.homepage, rest = JsonObject(all.filterKeys { it !in named }))
        }

        override fun serialize(encoder: Encoder, value: AgentOrganization) {
            val json = encoder as? JsonEncoder ?: throw SerializationException("a AgentOrganization is written as JSON alone")
            val known = json.json.encodeToJsonElement(Known.serializer(), Known(type = value.type, id = value.id, name = value.name, homepage = value.homepage)).jsonObject
            json.encodeJsonElement(JsonObject(known + value.rest))
        }
    }
}
