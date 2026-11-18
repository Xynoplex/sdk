// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Some jobs, named by fields of the job description: a partial description, at the description's own paths. A job matches when every field stated here equals the job's. A `mark` filter always states its motivation. */
@Serializable(with = JobFilterSerializer::class)
public sealed interface JobFilter

internal object JobFilterSerializer : TaggedUnionSerializer<JobFilter>(
    JobFilter::class,
    "jobType",
    members = { mapOf("mark" to MarkJobFilter.serializer(), "yield" to YieldJobFilter.serializer()) },
)
