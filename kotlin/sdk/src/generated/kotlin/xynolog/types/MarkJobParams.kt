// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The parameters of a `mark` job, told apart by `motivation`. Each motivation takes its own parameters and no others: a parameter a job does not take is refused where the job is created. */
@Serializable(with = MarkJobParamsSerializer::class)
public sealed interface MarkJobParams

internal object MarkJobParamsSerializer : TaggedUnionSerializer<MarkJobParams>(
    MarkJobParams::class,
    "motivation",
    members = { mapOf("highlighting" to HighlightingJobParams.serializer(), "commenting" to CommentingJobParams.serializer(), "assessing" to AssessingJobParams.serializer(), "linking" to LinkingJobParams.serializer(), "tagging" to TaggingJobParams.serializer()) },
)
