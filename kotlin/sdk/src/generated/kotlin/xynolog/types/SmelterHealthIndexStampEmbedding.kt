// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The embedding provider's kind and model. */
@Serializable
public data class SmelterHealthIndexStampEmbedding(
    public val type: String,
    public val model: String,
) {
    /** How Java makes a `SmelterHealthIndexStampEmbedding`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val type: String,
        private val model: String,
    ) {
        public fun build(): SmelterHealthIndexStampEmbedding = SmelterHealthIndexStampEmbedding(type = type, model = model)
    }

    public companion object {
        /** A builder of a `SmelterHealthIndexStampEmbedding` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(type: String, model: String): Builder = Builder(type, model)
    }
}
