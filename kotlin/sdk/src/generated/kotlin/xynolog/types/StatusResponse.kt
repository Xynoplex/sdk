// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonIgnoreUnknownKeys

@Serializable
@JsonIgnoreUnknownKeys
public data class StatusResponse(
    public val status: String,
    public val version: String,
    public val features: StatusResponseFeatures,
    public val message: String,
    public val authenticatedAs: String? = null,
) {
    /** How Java makes a `StatusResponse`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val status: String,
        private val version: String,
        private val features: StatusResponseFeatures,
        private val message: String,
    ) {
        private var authenticatedAs: String? = null

        public fun authenticatedAs(authenticatedAs: String?): Builder = apply { this.authenticatedAs = authenticatedAs }

        public fun build(): StatusResponse = StatusResponse(status = status, version = version, features = features, message = message, authenticatedAs = authenticatedAs)
    }

    public companion object {
        /** A builder of a `StatusResponse` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(status: String, version: String, features: StatusResponseFeatures, message: String): Builder = Builder(status, version, features, message)
    }
}
