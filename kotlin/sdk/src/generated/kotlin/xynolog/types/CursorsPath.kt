// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

/** The file a follower of the record keeps its cursors in: for each log of the record it follows, the sequence number of the last event of it taken (contract/TRANSPORT-CONTRACT.md § What repairs a passing frame). A file of the service's own disk, never of the knowledge base: a service that finds none starts each log as it starts one with no cursor, so losing it costs time and never correctness. */
public typealias CursorsPath = String
