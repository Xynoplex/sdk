// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** One entry in a directory listing: a file, which may carry the resource it was ingested as, or a subdirectory. Tell them apart by `type`, which is required on both and single-valued. */
@Serializable(with = DirectoryEntrySerializer::class)
public sealed interface DirectoryEntry

internal object DirectoryEntrySerializer : TaggedUnionSerializer<DirectoryEntry>(
    DirectoryEntry::class,
    "type",
    members = { mapOf("file" to FileEntry.serializer(), "dir" to DirEntry.serializer()) },
)
