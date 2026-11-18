// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Payload for mark:added domain event */
@Serializable
@JsonIgnoreUnknownKeys
public data class AnnotationAddedPayload(
    public val annotation: Annotation,
    /** SHA-256 of resource content at annotation time */
    public val contentChecksum: String? = null,
) {
    /** How Java makes a `AnnotationAddedPayload`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val annotation: Annotation,
    ) {
        private var contentChecksum: String? = null

        public fun contentChecksum(contentChecksum: String?): Builder = apply { this.contentChecksum = contentChecksum }

        public fun build(): AnnotationAddedPayload = AnnotationAddedPayload(annotation = annotation, contentChecksum = contentChecksum)
    }

    public companion object {
        /** A builder of a `AnnotationAddedPayload` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(annotation: Annotation): Builder = Builder(annotation)
    }
}
