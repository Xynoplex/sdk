// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** A graph kept in a Neo4j database. */
@Serializable
public data class Neo4jGraphConfig(
    @EncodeDefault
    public val type: Neo4jGraphConfigType = Neo4jGraphConfigType.Neo4j,
    /** Where the database is reached (`bolt://host:7687`). */
    public val uri: String,
    /** The user the service connects as. */
    public val username: String,
    /** The environment variable holding that user's password. The password is never a value here. */
    public val passwordEnv: String,
    /** Which of the server's databases holds the graph. */
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
