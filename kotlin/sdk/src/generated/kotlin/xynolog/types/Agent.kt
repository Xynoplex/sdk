// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

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

internal object AgentSerializer : TaggedUnionSerializer<Agent>(
    Agent::class,
    "@type",
    members = { mapOf("Person" to AgentPerson.serializer(), "Organization" to AgentOrganization.serializer(), "Software" to AgentSoftware.serializer()) },
)
