// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The model and the cut it makes an index by. */
@Serializable
public data class SmelterHealthIndexStamp(
    /** The embedding provider's kind and model. */
    public val embedding: SmelterHealthIndexStampEmbedding,
    public val chunking: SmelterChunking,
) {
    /** How Java makes a `SmelterHealthIndexStamp`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val embedding: SmelterHealthIndexStampEmbedding,
        private val chunking: SmelterChunking,
    ) {
        public fun build(): SmelterHealthIndexStamp = SmelterHealthIndexStamp(embedding = embedding, chunking = chunking)
    }

    public companion object {
        /** A builder of a `SmelterHealthIndexStamp` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(embedding: SmelterHealthIndexStampEmbedding, chunking: SmelterChunking): Builder = Builder(embedding, chunking)
    }
}
