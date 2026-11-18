// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** A write of an anchored-text entry for the bytes of one resource: what the Smelter derived from them, and their checksum. The Archivist files the entry under the checksum, so every resource whose bytes those are has it, and refuses the write when the resource's first representation has other bytes. */
@Serializable
public data class AnchoredTextWrite(
    /** The SHA-256 of the bytes the text was derived from, as 64 lower-case hexadecimal digits: the key the entry is filed under. */
    public val contentChecksum: String,
    public val entry: AnchoredTextEntry,
) {
    /** How Java makes a `AnchoredTextWrite`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val contentChecksum: String,
        private val entry: AnchoredTextEntry,
    ) {
        public fun build(): AnchoredTextWrite = AnchoredTextWrite(contentChecksum = contentChecksum, entry = entry)
    }

    public companion object {
        /** A builder of a `AnchoredTextWrite` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(contentChecksum: String, entry: AnchoredTextEntry): Builder = Builder(contentChecksum, entry)
    }
}
