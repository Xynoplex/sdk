// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** What a running job is doing right now, as a code plus typed params — never a prose sentence. The producer reports what happened; each client renders it in the user's language (react-ui from its translations, the Go launcher from its English map). One named schema per code, discriminated on `code`, so generated clients get typed variants and copy-map completeness is statically checkable. The vocabulary is every report Xynolog's worker makes (contract/WORKER-SERVICE.md, D16 to D19 and Y8); extending it means adding a named variant here and copy in every client, gated by the locale-completeness check. */
@Serializable(with = JobProgressMessageSerializer::class)
public sealed interface JobProgressMessage

internal object JobProgressMessageSerializer : TaggedUnionSerializer<JobProgressMessage>(
    JobProgressMessage::class,
    "code",
    members = { mapOf("loading" to JobProgressLoading.serializer(), "analyzing" to JobProgressAnalyzing.serializer(), "analyzing-tags" to JobProgressAnalyzingTags.serializer(), "generating-resource" to JobProgressGeneratingResource.serializer(), "creating-resource" to JobProgressCreatingResource.serializer(), "complete-generated" to JobProgressCompleteGenerated.serializer(), "detecting-entities" to JobProgressDetectingEntities.serializer(), "creating-annotations" to JobProgressCreatingAnnotations.serializer(), "creating-tag-annotations" to JobProgressCreatingTagAnnotations.serializer(), "complete-created" to JobProgressCompleteCreated.serializer()) },
)
