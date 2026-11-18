// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetAnnotationResponse(
    public val annotation: Annotation,
    public val resource: ResourceDescriptor?,
    public val resolvedResource: ResourceDescriptor?,
) {
    /** How Java makes a `GetAnnotationResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotation: Annotation,
        private val resource: ResourceDescriptor?,
        private val resolvedResource: ResourceDescriptor?,
    ) {
        public fun build(): GetAnnotationResponse = GetAnnotationResponse(annotation = annotation, resource = resource, resolvedResource = resolvedResource)
    }

    public companion object {
        /** A builder of a `GetAnnotationResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotation: Annotation, resource: ResourceDescriptor?, resolvedResource: ResourceDescriptor?): Builder = Builder(annotation, resource, resolvedResource)
    }
}
