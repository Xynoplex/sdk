// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** PROV-O wasAttributedTo — every party responsible for this annotation, DERIVED by the knowledge base from `creator` and the verified executor of the write: `[creator, generator]` when one agent requested the work and software produced it; collapsed to the one agent when requester and producer are the same. Never accepted from an emitter. */
@Serializable(with = AnnotationWasAttributedToSerializer::class)
public sealed interface AnnotationWasAttributedTo {
    /** A member that is a `List<Agent>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<Agent>) : AnnotationWasAttributedTo {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<Agent>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object AnnotationWasAttributedToSerializer : KindsUnionSerializer<AnnotationWasAttributedTo>(
    AnnotationWasAttributedTo::class,
    strings = { listOf(Agent.serializer()) },
    arrays = { listOf(Agent.serializer(), AnnotationWasAttributedTo.List.serializer()) },
    objects = { listOf(Agent.serializer()) },
)
