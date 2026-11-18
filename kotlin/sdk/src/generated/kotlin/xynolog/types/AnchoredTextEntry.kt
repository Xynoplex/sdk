// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive

/** One entry of the anchored-text store: the file `<ab>/<cd>/<key>.json` under the store's directory, where the key is the SHA-256 of the bytes the text was extracted from, in hex. The Smelter derives it and stores it over the Archivist's HTTP surface (`AnchoredTextWrite`); the Archivist writes it, as compact JSON with `v` and `stamp` first, to a sibling temporary file renamed onto the path. The stamp the Smelter states (`AnchoredTextStamp`) is kept, followed by a newline, in the file `STAMP` at the store's root. */
@Serializable(with = AnchoredTextEntrySerializer::class)
public sealed interface AnchoredTextEntry

internal object AnchoredTextEntrySerializer : JsonContentPolymorphicSerializer<AnchoredTextEntry>(AnchoredTextEntry::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.AnchoredTextEntry", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AnchoredTextEntry> =
        firstThatFits<AnchoredTextEntry>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(AnchoredTextExtractedEntry.serializer(), AnchoredTextDeclinedEntry.serializer())
            },
            "AnchoredTextEntry",
        )
}
