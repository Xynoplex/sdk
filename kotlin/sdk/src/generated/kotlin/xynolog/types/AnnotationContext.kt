// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/** W3C Web Annotation JSON-LD context */
@Serializable
public enum class AnnotationContext(
    /** The value as the wire spells it. */
    public val value: String,
) {
    @SerialName("http://www.w3.org/ns/anno.jsonld")
    HttpWwwW3OrgNsAnnoJsonld("http://www.w3.org/ns/anno.jsonld"),
}
