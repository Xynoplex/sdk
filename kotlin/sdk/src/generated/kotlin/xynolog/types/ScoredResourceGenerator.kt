// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Software peer that produced this resource (W3C Web Annotation model). Its identity is the verified emitter of the create; the parameters are the producer's to state. */
@Serializable(with = ScoredResourceGeneratorSerializer::class)
public sealed interface ScoredResourceGenerator {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : ScoredResourceGenerator {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ScoredResourceGeneratorSerializer : KindsUnionSerializer<ScoredResourceGenerator>(
    ScoredResourceGenerator::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), ScoredResourceGenerator.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
