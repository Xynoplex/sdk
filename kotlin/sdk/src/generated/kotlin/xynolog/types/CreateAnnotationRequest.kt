// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class CreateAnnotationRequest(
    public val motivation: Motivation,
    public val target: AnnotationTarget,
    /** Optional body. Omit for annotations whose motivation alone is meaningful (highlighting) or whose user-supplied content is empty. Shape matches Annotation.body. */
    public val body: AnnotationBodies? = null,
) {
    /** How Java makes a `CreateAnnotationRequest`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val motivation: Motivation,
        private val target: AnnotationTarget,
    ) {
        private var body: AnnotationBodies? = null

        public fun body(body: AnnotationBodies?): Builder = apply { this.body = body }

        public fun build(): CreateAnnotationRequest = CreateAnnotationRequest(motivation = motivation, target = target, body = body)
    }

    public companion object {
        /** A builder of a `CreateAnnotationRequest` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(motivation: Motivation, target: AnnotationTarget): Builder = Builder(motivation, target)
    }
}
