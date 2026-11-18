// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** Everything a worker reads at boot: nothing in it is defaulted by the worker. The launcher writes it for the machine's worker, from the knowledge bases on that worker's list: each local knowledge base as its start places it, from its stack documents, and each added by `xynolog worker kb add`, offered the engines of the local one it was added from. The worker reads it from the path its `--config` flag names (its image passes `/etc/xynolog/worker.json`). Whoever starts a worker another way writes the same document: this schema is the contract, and a worker needs no launcher. Started without `--config`, or with a path that names no file, the worker refuses to start and says which. No secret is a value here: a provider's key is named by the environment variable that holds it, and the key the worker signs in with at every knowledge base is `XYNOLOG_OIDC_CLIENT_KEY` in its environment, an RSA private key; each knowledge base names the client that holds its public half there. A document that does not validate is refused at boot, naming each failing field. */
@Serializable
public data class WorkerConfig(
    /** The knowledge bases this worker does jobs for. At each it signs in, confirms which knowledge base it reached and claims for its engines, apart from every other: one knowledge base's trouble stops that knowledge base's work alone (`contract/WORKER-SERVICE.md` § Knowledge bases). No two name one `domain`, which the worker refuses at boot. */
    public val knowledgeBases: kotlin.collections.List<WorkerKnowledgeBaseConfig>,
    /** The path of a model catalogue file: what each model of a provider can take, for the providers whose own APIs do not say (`google`, `openai`, `together`). A worker with an engine of one of those providers refuses to start where the file cannot be read, and where it states nothing of that engine's model. A worker with no such engine does not read it. */
    public val modelCatalogue: String,
    /** The port the worker answers `/health` on. */
    public val port: Long,
    public val logLevel: LogLevel,
    public val logFormat: LogFormat,
) {
    /** How Java makes a `WorkerConfig`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val knowledgeBases: kotlin.collections.List<WorkerKnowledgeBaseConfig>,
        private val modelCatalogue: String,
        private val port: Long,
        private val logLevel: LogLevel,
        private val logFormat: LogFormat,
    ) {
        public fun build(): WorkerConfig = WorkerConfig(knowledgeBases = knowledgeBases, modelCatalogue = modelCatalogue, port = port, logLevel = logLevel, logFormat = logFormat)
    }

    public companion object {
        /** A builder of a `WorkerConfig` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(knowledgeBases: kotlin.collections.List<WorkerKnowledgeBaseConfig>, modelCatalogue: String, port: Long, logLevel: LogLevel, logFormat: LogFormat): Builder = Builder(knowledgeBases, modelCatalogue, port, logLevel, logFormat)
    }
}
