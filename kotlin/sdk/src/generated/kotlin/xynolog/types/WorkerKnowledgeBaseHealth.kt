// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** One knowledge base the worker serves, as its health says it. `did` and `engines` are there while it is `working`, and only then. */
@Serializable
public data class WorkerKnowledgeBaseHealth(
    /** The entry's `domain`. */
    public val domain: String,
    /** `starting`: signing in, opening its stream, confirming it, or waiting to start again. `working`: confirmed, its engines claiming. `refused`: refused, until the service is started again. */
    public val state: WorkerKnowledgeBaseHealthState,
    /** The agent's DID at this knowledge base, as its gateway named it. */
    public val did: String? = null,
    /** One entry for each of the entry's engines, in its order. */
    public val engines: kotlin.collections.List<WorkerEngineHealth>? = null,
) {
    /** How Java makes a `WorkerKnowledgeBaseHealth`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val domain: String,
        private val state: WorkerKnowledgeBaseHealthState,
    ) {
        private var did: String? = null
        private var engines: kotlin.collections.List<WorkerEngineHealth>? = null

        public fun did(did: String?): Builder = apply { this.did = did }
        public fun engines(engines: kotlin.collections.List<WorkerEngineHealth>?): Builder = apply { this.engines = engines }

        public fun build(): WorkerKnowledgeBaseHealth = WorkerKnowledgeBaseHealth(domain = domain, state = state, did = did, engines = engines)
    }

    public companion object {
        /** A builder of a `WorkerKnowledgeBaseHealth` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(domain: String, state: WorkerKnowledgeBaseHealthState): Builder = Builder(domain, state)
    }
}
