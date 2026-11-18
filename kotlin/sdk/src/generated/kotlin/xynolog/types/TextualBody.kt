// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class TextualBody(
    @EncodeDefault
    public val type: TextualBodyType = TextualBodyType.TextualBody,
    /** The text content (e.g., entity type name) */
    public val value: String,
    /** Why this body is included */
    public val purpose: BodyPurpose? = null,
    /** MIME type (defaults to text/plain) */
    public val format: String? = null,
    /** BCP 47 language tag */
    public val language: String? = null,
) : AnnotationBody {
    /** How Java makes a `TextualBody`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val value: String,
    ) {
        private var purpose: BodyPurpose? = null
        private var format: String? = null
        private var language: String? = null

        public fun purpose(purpose: BodyPurpose?): Builder = apply { this.purpose = purpose }
        public fun format(format: String?): Builder = apply { this.format = format }
        public fun language(language: String?): Builder = apply { this.language = language }

        public fun build(): TextualBody = TextualBody(value = value, purpose = purpose, format = format, language = language)
    }

    public companion object {
        /** A builder of a `TextualBody` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(value: String): Builder = Builder(value)
    }
}
