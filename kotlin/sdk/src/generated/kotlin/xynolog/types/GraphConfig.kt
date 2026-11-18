// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The graph database a service writes or reads, and what that kind of database needs to be reached: one of the kinds `xynolog-graph` has a store for, told apart by `type`. A secret is never a value here: a database's password is named by the environment variable that holds it. */
@Serializable(with = GraphConfigSerializer::class)
public sealed interface GraphConfig

internal object GraphConfigSerializer : TaggedUnionSerializer<GraphConfig>(
    GraphConfig::class,
    "type",
    members = { mapOf("neo4j" to Neo4jGraphConfig.serializer(), "janusgraph" to JanusGraphConfig.serializer(), "neptune" to NeptuneGraphConfig.serializer(), "memory" to MemoryGraphConfig.serializer()) },
)
