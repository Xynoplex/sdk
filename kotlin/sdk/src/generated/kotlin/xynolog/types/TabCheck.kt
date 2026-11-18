// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** What checking one open resource against its knowledge base concluded. `gone` is the only verdict that closes it, and it means the knowledge base said the resource does not exist, not that the check failed: a failed transport, a timeout and a peer that is down are each `unknown`, and an unknown resource stays open. */
@Serializable(with = TabCheckSerializer::class)
public sealed interface TabCheck

internal object TabCheckSerializer : TaggedUnionSerializer<TabCheck>(
    TabCheck::class,
    "verdict",
    members = { mapOf("gone" to TabCheckGone.serializer(), "ready" to TabCheckReady.serializer(), "unknown" to TabCheckUnknown.serializer()) },
)
