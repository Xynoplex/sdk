// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.KeepGeneratedSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient
import kotlinx.serialization.json.JsonObject

/** A software peer, the Software branch of Agent: an agent, which is an account as a person is. Its `provider` and `model` are what it says of itself, attributed to it and not checked; the knowledge base reads neither from its DID. Its `name` is no part of what it writes: what it last said it is called is its profile, and readers fill it in, as they do a person's. A generator the knowledge base supplies, for an agent that supplied none, carries `@type` and `@id` alone. */
@Serializable(with = AgentSoftware.Serializer::class)
@KeepGeneratedSerializer
public data class AgentSoftware(
    @SerialName("@type")
    @EncodeDefault
    public val type: AgentSoftwareType = AgentSoftwareType.Software,
    /** The agent's DID: did:web:<domain>:agents:<subject>, its account at the knowledge base's issuer */
    @SerialName("@id")
    public val id: String? = null,
    /** What the agent last said it is called. ABSENT until resolved: filled in from its profile when a record is read, as a Person's name is. Absent also where it has said nothing. Not parsed. */
    public val name: String? = null,
    /** Inference provider (e.g. ollama, anthropic) */
    public val provider: String? = null,
    /** Model identifier (e.g. gemma2:27b, claude-3-5-sonnet) */
    public val model: String? = null,
    /** Inference parameters (temperature, maxTokens, systemPrompt, etc.). Runtime metadata, not part of identity. */
    public val parameters: JsonObject? = null,
    /** Every property the schema does not name, as it came. */
    @Transient
    public val rest: JsonObject = JsonObject(emptyMap()),
) : Agent {
    /** How Java makes a `AgentSoftware`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor() {
        private var id: String? = null
        private var name: String? = null
        private var provider: String? = null
        private var model: String? = null
        private var parameters: JsonObject? = null
        private var rest: JsonObject = JsonObject(emptyMap())

        public fun id(id: String?): Builder = apply { this.id = id }
        public fun name(name: String?): Builder = apply { this.name = name }
        public fun provider(provider: String?): Builder = apply { this.provider = provider }
        public fun model(model: String?): Builder = apply { this.model = model }
        public fun parameters(parameters: JsonObject?): Builder = apply { this.parameters = parameters }
        public fun rest(rest: JsonObject): Builder = apply { this.rest = rest }

        public fun build(): AgentSoftware = AgentSoftware(id = id, name = name, provider = provider, model = model, parameters = parameters, rest = rest)
    }

    public companion object {
        /** A builder of a `AgentSoftware` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(): Builder = Builder()
    }

    internal object Serializer : OpenObjectSerializer<AgentSoftware>(
        AgentSoftware.generatedSerializer(),
        AgentSoftware::rest,
        { named, rest -> named.copy(rest = rest) },
    )
}
