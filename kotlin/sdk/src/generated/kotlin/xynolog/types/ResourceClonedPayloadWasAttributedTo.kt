// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** PROV-O wasAttributedTo, derived at write time: the cloner alone. The value the resource view carries. */
@Serializable(with = ResourceClonedPayloadWasAttributedToSerializer::class)
public sealed interface ResourceClonedPayloadWasAttributedTo {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ResourceClonedPayloadWasAttributedTo {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ResourceClonedPayloadWasAttributedToSerializer : KindsUnionSerializer<ResourceClonedPayloadWasAttributedTo>(
    ResourceClonedPayloadWasAttributedTo::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), ResourceClonedPayloadWasAttributedTo.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
