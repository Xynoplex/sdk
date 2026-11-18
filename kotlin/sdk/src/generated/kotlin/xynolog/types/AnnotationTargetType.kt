// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Stated by the annotation of a span: the target is a part of its source, which the selector picks out. An annotation of a resource as a whole states none. */
@Serializable
public enum class AnnotationTargetType(
    /** The value as the wire spells it. */
    public val value: String,
) {
    SpecificResource("SpecificResource"),
}
