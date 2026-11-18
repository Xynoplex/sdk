// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)

package xynolog.types

import kotlinx.serialization.Serializable

/** One of the knowledge base's engines: a provider and a model its Inference document names, and the jobs the document has it used for. An engine is not a principal: whichever worker claims a job does it, under its own account, and names on each write the engine it used, if any. Carries no inference limits: the services that hold the inference credentials report those (InferenceLimitsResult). */
@Serializable
public data class EngineEntry(
    public val engine: Engine,
    /** The jobs the knowledge base's Inference document has this engine used for, as a claim names them. Absent for an engine only Librarian actors ask. */
    public val jobs: kotlin.collections.List<JobFilter>? = null,
) {
    /** How Java makes a `EngineEntry`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val engine: Engine,
    ) {
        private var jobs: kotlin.collections.List<JobFilter>? = null

        public fun jobs(jobs: kotlin.collections.List<JobFilter>?): Builder = apply { this.jobs = jobs }

        public fun build(): EngineEntry = EngineEntry(engine = engine, jobs = jobs)
    }

    public companion object {
        /** A builder of a `EngineEntry` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(engine: Engine): Builder = Builder(engine)
    }
}
