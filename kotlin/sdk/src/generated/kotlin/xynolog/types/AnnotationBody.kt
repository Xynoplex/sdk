// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** An annotation's body: a TextualBody carries text the annotation states (entity tags, descriptions, comments), a SpecificResource points at what it links to. Tell them apart by `type`, which is required on both and single-valued — a consumer never has to probe for which fields happen to be present. */
@Serializable(with = AnnotationBodySerializer::class)
public sealed interface AnnotationBody : AnnotationBodies

internal object AnnotationBodySerializer : TaggedUnionSerializer<AnnotationBody>(
    AnnotationBody::class,
    "type",
    members = { mapOf("TextualBody" to TextualBody.serializer(), "SpecificResource" to SpecificResource.serializer()) },
)
