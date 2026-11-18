// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The two numbers a text is cut by before it is embedded, both in tokens, a token being taken as four code points. */
@Serializable
public data class SmelterConfigChunking(
    /** The size of a chunk. */
    public val chunkSize: Long,
    /** How much of a chunk the next one repeats. */
    public val overlap: Long,
) {
    /** How Java makes a `SmelterConfigChunking`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val chunkSize: Long,
        private val overlap: Long,
    ) {
        public fun build(): SmelterConfigChunking = SmelterConfigChunking(chunkSize = chunkSize, overlap = overlap)
    }

    public companion object {
        /** A builder of a `SmelterConfigChunking` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(chunkSize: Long, overlap: Long): Builder = Builder(chunkSize, overlap)
    }
}
