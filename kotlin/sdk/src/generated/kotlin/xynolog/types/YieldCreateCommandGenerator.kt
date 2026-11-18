// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The Software peer that produced the content, when software did. Its identity must be the emitter's own — the knowledge base refuses a generator naming anyone else, and supplies it from the verified emitter when omitted. `creator` and `wasAttributedTo` are never sent; the knowledge base derives them from the emitter and the cited job. */
@Serializable(with = YieldCreateCommandGeneratorSerializer::class)
public sealed interface YieldCreateCommandGenerator {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : YieldCreateCommandGenerator {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object YieldCreateCommandGeneratorSerializer : KindsUnionSerializer<YieldCreateCommandGenerator>(
    YieldCreateCommandGenerator::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), YieldCreateCommandGenerator.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
