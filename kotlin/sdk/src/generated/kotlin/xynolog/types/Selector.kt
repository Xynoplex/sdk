// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** One W3C selector: a way of finding a segment of a resource. Tell them apart by `type`, which is required on each and single-valued. */
@Serializable(with = SelectorSerializer::class)
public sealed interface Selector : AnnotationSelector

internal object SelectorSerializer : TaggedUnionSerializer<Selector>(
    Selector::class,
    "type",
    members = { mapOf("TextPositionSelector" to TextPositionSelector.serializer(), "TextQuoteSelector" to TextQuoteSelector.serializer(), "SvgSelector" to SvgSelector.serializer(), "FragmentSelector" to FragmentSelector.serializer()) },
)
