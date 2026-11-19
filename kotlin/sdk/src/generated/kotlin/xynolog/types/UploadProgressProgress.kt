// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** Bytes were sent. */
@Serializable
public data class UploadProgressProgress(
    @EncodeDefault
    public val phase: UploadProgressProgressPhase = UploadProgressProgressPhase.Progress,
    /** How many bytes are sent so far. */
    public val bytesUploaded: Long,
    /** How many bytes the upload is. */
    public val totalBytes: Long,
) : UploadProgress {
    /** How Java makes a `UploadProgressProgress`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val bytesUploaded: Long,
        private val totalBytes: Long,
    ) {
        public fun build(): UploadProgressProgress = UploadProgressProgress(bytesUploaded = bytesUploaded, totalBytes = totalBytes)
    }

    public companion object {
        /** A builder of a `UploadProgressProgress` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(bytesUploaded: Long, totalBytes: Long): Builder = Builder(bytesUploaded, totalBytes)
    }
}
