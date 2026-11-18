// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** W3C PROV — every party responsible for this resource, derived by the knowledge base at creation from verified identities: `[requester, generator]` for a resource a job produced, collapsed to the one agent when the requester produced it. Never accepted from an emitter. */
@Serializable(with = ResourceDescriptorWasAttributedToSerializer::class)
public sealed interface ResourceDescriptorWasAttributedTo {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ResourceDescriptorWasAttributedTo {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ResourceDescriptorWasAttributedToSerializer : KindsUnionSerializer<ResourceDescriptorWasAttributedTo>(
    ResourceDescriptorWasAttributedTo::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), ResourceDescriptorWasAttributedTo.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
