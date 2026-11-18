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
 * A graph kept in a Neo4j database.
 */
@Serializable
public data class Neo4jGraphConfig(
    @SerialName("type")
    @EncodeDefault
    public val type: Neo4jGraphConfigType = Neo4jGraphConfigType.Neo4j,
    /**
     * Where the database is reached (`bolt://host:7687`).
     */
    @SerialName("uri")
    public val uri: String,
    /**
     * The user the service connects as.
     */
    @SerialName("username")
    public val username: String,
    /**
     * The environment variable holding that user's password. The password is never a value here.
     */
    @SerialName("passwordEnv")
    public val passwordEnv: String,
    /**
     * Which of the server's databases holds the graph.
     */
    @SerialName("database")
    public val database: String,
) : GraphConfig {
    /** How Java makes a `Neo4jGraphConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val uri: String,
        private val username: String,
        private val passwordEnv: String,
        private val database: String,
    ) {
        public fun build(): Neo4jGraphConfig = Neo4jGraphConfig(uri = uri, username = username, passwordEnv = passwordEnv, database = database)
    }

    public companion object {
        /** A builder of a `Neo4jGraphConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(uri: String, username: String, passwordEnv: String, database: String): Builder = Builder(uri, username, passwordEnv, database)
    }
}
