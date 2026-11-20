// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What an upload reports as it goes, told apart by `phase`: its size first, then the bytes sent so far, then the resource made. */
@Serializable(with = UploadProgressSerializer::class)
public sealed interface UploadProgress

internal object UploadProgressSerializer : TaggedUnionSerializer<UploadProgress>(
    UploadProgress::class,
    "phase",
    members = { mapOf("started" to UploadProgressStarted.serializer(), "progress" to UploadProgressProgress.serializer(), "finished" to UploadProgressFinished.serializer()) },
)
