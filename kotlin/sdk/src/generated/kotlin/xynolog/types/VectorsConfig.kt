// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** The vector index a service writes or searches, and what that kind of index needs to be reached: one of the kinds `xynolog-vectors` has a store for, told apart by `type`. */
@Serializable(with = VectorsConfigSerializer::class)
public sealed interface VectorsConfig

internal object VectorsConfigSerializer : TaggedUnionSerializer<VectorsConfig>(
    VectorsConfig::class,
    "type",
    members = { mapOf("qdrant" to QdrantVectorsConfig.serializer(), "memory" to MemoryVectorsConfig.serializer()) },
)
