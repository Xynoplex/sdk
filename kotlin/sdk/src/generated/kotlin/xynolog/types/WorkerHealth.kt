// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class)

package xynolog.types

import kotlinx.serialization.EncodeDefault
import kotlinx.serialization.Serializable

/** The Worker service's health answer (WORKER-SERVICE H1). It answers only once a knowledge base of its document is confirmed, so a 200 means it is working somewhere. */
@Serializable
public data class WorkerHealth(
    @EncodeDefault
    public val status: WorkerHealthStatus = WorkerHealthStatus.Ok,
    /** One entry for each of the document's `knowledgeBases`, in its order. */
    public val knowledgeBases: kotlin.collections.List<WorkerKnowledgeBaseHealth>,
) {
    /** How Java makes a `WorkerHealth`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val knowledgeBases: kotlin.collections.List<WorkerKnowledgeBaseHealth>,
    ) {
        public fun build(): WorkerHealth = WorkerHealth(knowledgeBases = knowledgeBases)
    }

    public companion object {
        /** A builder of a `WorkerHealth` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(knowledgeBases: kotlin.collections.List<WorkerKnowledgeBaseHealth>): Builder = Builder(knowledgeBases)
    }
}
