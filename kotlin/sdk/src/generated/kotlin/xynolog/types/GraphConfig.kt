// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.ExperimentalSerializationApi
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.builtins.ListSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.descriptors.nullable
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonIgnoreUnknownKeys
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.serializer
import xynolog.identifiers.AnnotationId
import xynolog.identifiers.JobId
import xynolog.identifiers.ResourceId
import xynolog.identifiers.UserId

/**
 * The graph database a service writes or reads, and what that kind of database needs to be reached: one of the kinds `xynolog-graph` has a store for, told apart by `type`. A secret is never a value here: a database's password is named by the environment variable that holds it.
 */
@Serializable(with = GraphConfigSerializer::class)
public sealed interface GraphConfig

internal object GraphConfigSerializer : JsonContentPolymorphicSerializer<GraphConfig>(GraphConfig::class) {
    override val descriptor: SerialDescriptor = SerialDescriptor("xynolog.types.GraphConfig", super.descriptor)

    override fun selectDeserializer(element: JsonElement): DeserializationStrategy<GraphConfig> =
        when (((element as? JsonObject)?.get("type") as? JsonPrimitive)?.content) {
            "neo4j" -> Neo4jGraphConfig.serializer()
            "janusgraph" -> JanusGraphConfig.serializer()
            "neptune" -> NeptuneGraphConfig.serializer()
            "memory" -> MemoryGraphConfig.serializer()
            else -> throw SerializationException("a GraphConfig states a `type` that is one of `neo4j`, `janusgraph`, `neptune`, `memory`")
        }
}
