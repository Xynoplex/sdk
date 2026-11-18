// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** The engine a Librarian actor asks: which it is, and where its provider is reached. */
@Serializable
public data class LibrarianEngineConfig(
    public val engine: Engine,
    /** The address the provider's API is reached at. */
    public val baseUrl: String,
    /** The environment variable holding the provider's API key, when the provider requires one. */
    public val apiKeyEnv: String? = null,
) {
    /** How Java makes a `LibrarianEngineConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
        private val baseUrl: String,
    ) {
        private var apiKeyEnv: String? = null

        public fun apiKeyEnv(apiKeyEnv: String?): Builder = apply { this.apiKeyEnv = apiKeyEnv }

        public fun build(): LibrarianEngineConfig = LibrarianEngineConfig(engine = engine, baseUrl = baseUrl, apiKeyEnv = apiKeyEnv)
    }

    public companion object {
        /** A builder of a `LibrarianEngineConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine, baseUrl: String): Builder = Builder(engine, baseUrl)
    }
}
