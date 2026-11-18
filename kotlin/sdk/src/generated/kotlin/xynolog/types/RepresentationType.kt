// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Type(s), e.g., schema:MediaObject. */
@Serializable(with = RepresentationTypeSerializer::class)
public sealed interface RepresentationType {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : RepresentationType {
        internal object Serializer : WrapperSerializer<Text, String>(Text::class, kotlinx.serialization.serializer(), { Text(it) }, Text::value)
    }

    /** A member that is a `List<String>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<String>) : RepresentationType {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<String>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object RepresentationTypeSerializer : KindsUnionSerializer<RepresentationType>(
    RepresentationType::class,
    strings = { listOf(RepresentationType.Text.serializer()) },
    arrays = { listOf(RepresentationType.List.serializer()) },
    objects = { emptyList() },
)
