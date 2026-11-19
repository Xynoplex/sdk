// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Where a quoted selection was found in a text, and how it was found, told apart by `anchorMethod`, one of AnchorMethod's words: a fuzzy match also names its search, `matchQuality`, and no other states one. */
@Serializable(with = ReconciledSpanSerializer::class)
public sealed interface ReconciledSpan

internal object ReconciledSpanSerializer : TaggedUnionSerializer<ReconciledSpan>(
    ReconciledSpan::class,
    "anchorMethod",
    members = { mapOf("unique-match" to ReconciledSpanUniqueMatch.serializer(), "context-recovered" to ReconciledSpanContextRecovered.serializer(), "first-of-many" to ReconciledSpanFirstOfMany.serializer(), "fuzzy-match" to ReconciledSpanFuzzyMatch.serializer()) },
)
