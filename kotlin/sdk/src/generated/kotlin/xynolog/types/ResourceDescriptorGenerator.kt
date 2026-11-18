// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Software peer that produced this resource (W3C Web Annotation model). Its identity is the verified emitter of the create; the parameters are the producer's to state. */
@Serializable(with = ResourceDescriptorGeneratorSerializer::class)
public sealed interface ResourceDescriptorGenerator {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ResourceDescriptorGenerator {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ResourceDescriptorGeneratorSerializer : KindsUnionSerializer<ResourceDescriptorGenerator>(
    ResourceDescriptorGenerator::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), ResourceDescriptorGenerator.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
