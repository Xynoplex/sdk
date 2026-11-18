// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** PROV-O wasAttributedTo, derived at write time from `creator` and the executor: both parties when they differ, one when they are the same. The value the resource view carries; readers do not re-derive it. */
@Serializable(with = ResourceCreatedPayloadWasAttributedToSerializer::class)
public sealed interface ResourceCreatedPayloadWasAttributedTo {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ResourceCreatedPayloadWasAttributedTo {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ResourceCreatedPayloadWasAttributedToSerializer : KindsUnionSerializer<ResourceCreatedPayloadWasAttributedTo>(
    ResourceCreatedPayloadWasAttributedTo::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), ResourceCreatedPayloadWasAttributedTo.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
