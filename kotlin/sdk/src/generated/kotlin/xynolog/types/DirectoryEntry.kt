// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/** One entry in a directory listing: a file, which may carry the resource it was ingested as, or a subdirectory. Tell them apart by `type`, which is required on both and single-valued. */
@Serializable(with = DirectoryEntrySerializer::class)
public sealed interface DirectoryEntry

internal object DirectoryEntrySerializer : JsonContentPolymorphicSerializer<DirectoryEntry>(DirectoryEntry::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.DirectoryEntry", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<DirectoryEntry> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "file" -> FileEntry.serializer()
            "dir" -> DirEntry.serializer()
            else -> throw SerializationException("a DirectoryEntry states a `type` that is one of `file`, `dir`")
        }
}
