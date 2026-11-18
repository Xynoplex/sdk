// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The full outcome of text extraction for one representation — the record the anchored-text store holds and the wire serves. Discriminated on `kind`: 'extracted' — the anchored text with its provenance; 'declined' — a named decline. ocrConfidence is extraction quality for operators, deliberately not anchor confidence. */
@Serializable(with = ExtractionOutcomeSerializer::class)
public sealed interface ExtractionOutcome

internal object ExtractionOutcomeSerializer : TaggedUnionSerializer<ExtractionOutcome>(
    ExtractionOutcome::class,
    "kind",
    members = { mapOf("extracted" to ExtractedText.serializer(), "declined" to ExtractionDeclined.serializer()) },
)
