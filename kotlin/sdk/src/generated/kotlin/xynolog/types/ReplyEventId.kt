// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

/** `e-<channel>:<correlationId>` — the id of a frame that carries a correlationId. Deterministic: the same reply has the same id on every connection, so a copy arriving on two connections (a reconnect overlap, or a replay of a retained reply) dedups. Never a resumption watermark. */
public typealias ReplyEventId = String
