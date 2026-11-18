// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/** Web Annotation / W3C PROV Agent. Discriminated by @type — Person, Organization, or Software (named member schemas: AgentPerson, AgentOrganization, AgentSoftware). Software peers are first-class participants, not a sub-class of Person. */
@Serializable(with = AgentSerializer::class)
public sealed interface Agent :
    AnnotationGenerator,
    AnnotationWasAttributedTo,
    ResourceClonedPayloadWasAttributedTo,
    ResourceCreatedPayloadGenerator,
    ResourceCreatedPayloadWasAttributedTo,
    ResourceDescriptorGenerator,
    ResourceDescriptorWasAttributedTo,
    ScoredResourceGenerator,
    ScoredResourceWasAttributedTo,
    YieldCreateCommandGenerator

internal object AgentSerializer : JsonContentPolymorphicSerializer<Agent>(Agent::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.Agent", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<Agent> =
        when (((element as? JsonObject)?.get("@type") as? JsonPrimitive)?.content) {
            "Person" -> AgentPerson.serializer()
            "Organization" -> AgentOrganization.serializer()
            "Software" -> AgentSoftware.serializer()
            else -> throw SerializationException("a Agent states a `@type` that is one of `Person`, `Organization`, `Software`")
        }
}
