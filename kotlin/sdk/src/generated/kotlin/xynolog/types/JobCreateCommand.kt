// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Create a job. A job description is its `jobType` and enough parameters to be well formed: a `mark` job names its resource and, in its parameters, its motivation; a `yield` job names its context. */
@Serializable(with = JobCreateCommandSerializer::class)
public sealed interface JobCreateCommand

internal object JobCreateCommandSerializer : TaggedUnionSerializer<JobCreateCommand>(
    JobCreateCommand::class,
    "jobType",
    members = { mapOf("mark" to MarkJobCreateCommand.serializer(), "yield" to YieldJobCreateCommand.serializer()) },
)
