// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.KeepGeneratedSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient
import kotlinx.serialization.json.JsonObject

/** An organization — the Organization branch of Agent. */
@Serializable(with = AgentOrganization.Serializer::class)
@KeepGeneratedSerializer
public data class AgentOrganization(
    @SerialName("@type")
    @EncodeDefault
    public val type: AgentOrganizationType = AgentOrganizationType.Organization,
    @SerialName("@id")
    public val id: String? = null,
    public val name: String,
    public val homepage: String? = null,
    /** Every property the schema does not name, as it came. */
    @Transient
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

    internal object Serializer : OpenObjectSerializer<AgentOrganization>(
        AgentOrganization.generatedSerializer(),
        AgentOrganization::rest,
        { named, rest -> named.copy(rest = rest) },
    )
}
