// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class GetResourceResponse(
    public val resource: ResourceDescriptor,
    /** All annotations for the resource (highlights, references, assessments, etc.) */
    public val annotations: kotlin.collections.List<Annotation>,
) {
    /** How Java makes a `GetResourceResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val resource: ResourceDescriptor,
        private val annotations: kotlin.collections.List<Annotation>,
    ) {
        public fun build(): GetResourceResponse = GetResourceResponse(resource = resource, annotations = annotations)
    }

    public companion object {
        /** A builder of a `GetResourceResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(resource: ResourceDescriptor, annotations: kotlin.collections.List<Annotation>): Builder = Builder(resource, annotations)
    }
}
