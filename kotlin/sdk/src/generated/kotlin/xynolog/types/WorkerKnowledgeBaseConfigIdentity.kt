// Generated from the component schemas in protocol/specs/src; do not edit.
// Regenerate: make generate (codegen/lib/kotlin_sdk/kotlin_sdk.ml)
@file:OptIn(kotlinx.serialization.ExperimentalSerializationApi::class, kotlin.ExperimentalStdlibApi::class)

package xynolog.types

import kotlinx.serialization.Serializable

/** Where the worker signs in for this knowledge base, and as which client. */
@Serializable
public data class WorkerKnowledgeBaseConfigIdentity(
    /** The issuer URL, exactly as tokens carry it in `iss`. */
    public val issuer: String,
    /** The client the issuer holds the public half of the worker's key on: the worker's account at this knowledge base. It is also what the worker says it is called there (`principal:profile`). */
    public val clientId: String,
) {
    /** How Java makes a `WorkerKnowledgeBaseConfigIdentity`: `builder` takes what it must state, a setter each thing it may, and `build` makes it. */
    public class Builder internal constructor(
        private val issuer: String,
        private val clientId: String,
    ) {
        public fun build(): WorkerKnowledgeBaseConfigIdentity = WorkerKnowledgeBaseConfigIdentity(issuer = issuer, clientId = clientId)
    }

    public companion object {
        /** A builder of a `WorkerKnowledgeBaseConfigIdentity` that states these, and what its setters add. */
        @JvmStatic
        public fun builder(issuer: String, clientId: String): Builder = Builder(issuer, clientId)
    }
}
