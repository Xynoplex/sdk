// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

@Serializable(with = ResourceCreatedPayloadGeneratorSerializer::class)
public sealed interface ResourceCreatedPayloadGenerator {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ResourceCreatedPayloadGenerator {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ResourceCreatedPayloadGeneratorSerializer : KindsUnionSerializer<ResourceCreatedPayloadGenerator>(
    ResourceCreatedPayloadGenerator::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), ResourceCreatedPayloadGenerator.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
