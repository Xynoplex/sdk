// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** One engine a worker runs: which it is, the jobs the worker claims to do with it, and where its provider is reached. */
@Serializable
public data class WorkerEngineConfig(
    public val engine: Engine,
    /** The jobs the worker claims to do with this engine, as a claim names them (`job:claim`'s `accepts`): it claims with these filters and no other. */
    public val jobs: kotlin.collections.List<JobFilter>,
    /** The address the provider's API is reached at. */
    public val baseUrl: String,
    /** The environment variable holding the provider's API key, when the provider requires one. */
    public val apiKeyEnv: String? = null,
) {
    /** How Java makes a `WorkerEngineConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
        private val jobs: kotlin.collections.List<JobFilter>,
        private val baseUrl: String,
    ) {
        private var apiKeyEnv: String? = null

        public fun apiKeyEnv(apiKeyEnv: String?): Builder = apply { this.apiKeyEnv = apiKeyEnv }

        public fun build(): WorkerEngineConfig = WorkerEngineConfig(engine = engine, jobs = jobs, baseUrl = baseUrl, apiKeyEnv = apiKeyEnv)
    }

    public companion object {
        /** A builder of a `WorkerEngineConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine, jobs: kotlin.collections.List<JobFilter>, baseUrl: String): Builder = Builder(engine, jobs, baseUrl)
    }
}
