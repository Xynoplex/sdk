// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Web Annotation generator — the Software peer that produced the annotation, when software did. Absent for a person's own annotation. An emitter may supply it to carry the model's parameters, but its identity must be the emitter's own: the knowledge base refuses a generator naming anyone else, and supplies it from the verified emitter when omitted. One producer per write — a write carrying the array form is refused. */
@Serializable(with = AnnotationGeneratorSerializer::class)
public sealed interface AnnotationGenerator {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : AnnotationGenerator {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object AnnotationGeneratorSerializer : KindsUnionSerializer<AnnotationGenerator>(
    AnnotationGenerator::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), AnnotationGenerator.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
