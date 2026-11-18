// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

/** Liveness: the process is up and serving. It asks nothing of the Archivist or the broker — a gateway that cannot reach them refuses to start, so one that answers here got past both at boot. */
@Serializable
@JsonIgnoreUnknownKeys
public data class HealthResponse(
    public val status: String,
    public val message: String,
    public val version: String,
    public val timestamp: String,
) {
    /** How Java makes a `HealthResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val status: String,
        private val message: String,
        private val version: String,
        private val timestamp: String,
    ) {
        public fun build(): HealthResponse = HealthResponse(status = status, message = message, version = version, timestamp = timestamp)
    }

    public companion object {
        /** A builder of a `HealthResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(status: String, message: String, version: String, timestamp: String): Builder = Builder(status, message, version, timestamp)
    }
}
