// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Profile/shape URI this resource description conforms to. */
@Serializable(with = ResourceDescriptorConformsToSerializer::class)
public sealed interface ResourceDescriptorConformsTo {
    /** A member that is a `String`, as the value itself. */
    @Serializable(with = Text.Serializer::class)
    public data class Text(public val value: String) : ResourceDescriptorConformsTo {
        internal object Serializer : WrapperSerializer<Text, String>(Text::class, kotlinx.serialization.serializer(), { Text(it) }, Text::value)
    }

    /** A member that is a `List<String>`, as the value itself. */
    @Serializable(with = List.Serializer::class)
    public data class List(public val value: kotlin.collections.List<String>) : ResourceDescriptorConformsTo {
        internal object Serializer : WrapperSerializer<List, kotlin.collections.List<String>>(List::class, kotlinx.serialization.serializer(), { List(it) }, List::value)
    }
}

internal object ResourceDescriptorConformsToSerializer : KindsUnionSerializer<ResourceDescriptorConformsTo>(
    ResourceDescriptorConformsTo::class,
    strings = { listOf(ResourceDescriptorConformsTo.Text.serializer()) },
    arrays = { listOf(ResourceDescriptorConformsTo.List.serializer()) },
    objects = { emptyList() },
)
