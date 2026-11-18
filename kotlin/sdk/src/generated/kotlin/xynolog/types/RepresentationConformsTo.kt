// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Profile/shape the bytes conform to (e.g., a JSON profile or SVG profile). */
@Serializable(with = RepresentationConformsToSerializer::class)
public sealed interface RepresentationConformsTo {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : RepresentationConformsTo {
        internal object Serializer : WrapperSerializer<Text, String>(Text::class, kotlinx.serialization.serializer(), { Text(it) }, Text::value)
    }

    /** A member that is a `List<String>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<String>) : RepresentationConformsTo {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<String>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object RepresentationConformsToSerializer : KindsUnionSerializer<RepresentationConformsTo>(
    RepresentationConformsTo::class,
    strings = { listOf(RepresentationConformsTo.Text.serializer()) },
    arrays = { listOf(RepresentationConformsTo.List.serializer()) },
    objects = { emptyList() },
)
