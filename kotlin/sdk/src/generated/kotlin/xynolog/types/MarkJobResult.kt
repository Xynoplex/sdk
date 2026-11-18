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

/** What a `mark` job reports when it concludes without failing: its counts, or a decline. Neither names its kind: a decline is the one with `declined`. */
@Serializable(with = MarkJobResultSerializer::class)
public sealed interface MarkJobResult

internal object MarkJobResultSerializer : JsonContentPolymorphicSerializer<MarkJobResult>(MarkJobResult::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.MarkJobResult", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<MarkJobResult> =
        firstThatFits<MarkJobResult>(
            element,
            when (element) {
                is JsonPrimitive -> if (element.isString) listOf() else emptyList()
                is JsonArray -> listOf()
                is JsonObject -> listOf(MarkJobDone.serializer(), JobDeclined.serializer())
            },
            "MarkJobResult",
        )
}
