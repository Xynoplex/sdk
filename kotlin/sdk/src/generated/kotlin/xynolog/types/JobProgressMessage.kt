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

/** What a running job is doing right now, as a code plus typed params — never a prose sentence. The producer reports what happened; each client renders it in the user's language (react-ui from its translations, the Go launcher from its English map). One named schema per code, discriminated on `code`, so generated clients get typed variants and copy-map completeness is statically checkable. The vocabulary is every report Xynolog's worker makes (contract/WORKER-SERVICE.md, D16 to D19 and Y8); extending it means adding a named variant here and copy in every client, gated by the locale-completeness check. */
@Serializable(with = JobProgressMessageSerializer::class)
public sealed interface JobProgressMessage

internal object JobProgressMessageSerializer : JsonContentPolymorphicSerializer<JobProgressMessage>(JobProgressMessage::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.JobProgressMessage", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<JobProgressMessage> =
        when (((element as? JsonObject)?.get("code") as? JsonPrimitive)?.content) {
            "loading" -> JobProgressLoading.serializer()
            "analyzing" -> JobProgressAnalyzing.serializer()
            "analyzing-tags" -> JobProgressAnalyzingTags.serializer()
            "generating-resource" -> JobProgressGeneratingResource.serializer()
            "creating-resource" -> JobProgressCreatingResource.serializer()
            "complete-generated" -> JobProgressCompleteGenerated.serializer()
            "detecting-entities" -> JobProgressDetectingEntities.serializer()
            "creating-annotations" -> JobProgressCreatingAnnotations.serializer()
            "creating-tag-annotations" -> JobProgressCreatingTagAnnotations.serializer()
            "complete-created" -> JobProgressCompleteCreated.serializer()
            else -> throw SerializationException("a JobProgressMessage states a `code` that is one of `loading`, `analyzing`, `analyzing-tags`, `generating-resource`, `creating-resource`, `complete-generated`, `detecting-entities`, `creating-annotations`, `creating-tag-annotations`, `complete-created`")
        }
}
