// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a knowledge base said when it was asked to describe itself, read against the entry it was asked as. */
@Serializable(with = KbReadVerdictSerializer::class)
public sealed interface KbReadVerdict

internal object KbReadVerdictSerializer : TaggedUnionSerializer<KbReadVerdict>(
    KbReadVerdict::class,
    "kind",
    members = { mapOf("recorded" to KbReadVerdictRecorded.serializer(), "conflict" to KbReadVerdictConflict.serializer(), "no-verdict" to KbReadVerdictNoVerdict.serializer()) },
)
