// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** A job as the dispatcher holds it. Its `status` decides which timestamps and outcome fields it carries. It is what a claim returns (`job:claimed`, always `running`) and what the queue stores, inside a JobRecord. */
@Serializable(with = JobSerializer::class)
public sealed interface Job

internal object JobSerializer : TaggedUnionSerializer<Job>(
    Job::class,
    "status",
    members = { mapOf("pending" to JobPending.serializer(), "running" to JobRunning.serializer(), "complete" to JobComplete.serializer(), "failed" to JobFailed.serializer(), "cancelled" to JobCancelled.serializer()) },
)
