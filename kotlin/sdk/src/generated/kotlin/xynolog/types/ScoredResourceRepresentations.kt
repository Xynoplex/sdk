// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Managed or referenced byte-level renditions of this resource. */
@Serializable(with = ScoredResourceRepresentationsSerializer::class)
public sealed interface ScoredResourceRepresentations {
    /** A member that is a `List<Representation>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Representation>) : ScoredResourceRepresentations {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Representation>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ScoredResourceRepresentationsSerializer : KindsUnionSerializer<ScoredResourceRepresentations>(
    ScoredResourceRepresentations::class,
    strings = { emptyList() },
    arrays = { listOf(ScoredResourceRepresentations.List.serializer()) },
    objects = { listOf(Representation.serializer()) },
)
